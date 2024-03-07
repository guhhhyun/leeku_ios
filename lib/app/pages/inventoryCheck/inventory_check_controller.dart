import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:table_calendar/table_calendar.dart';


class InventoryCheckController extends GetxController {

  var textController = TextEditingController(); // 거래처명
  var textController2 = TextEditingController(); // 두께

  RxMap<String, String> selectedCmpMap = {'FG_CODE':'', 'FG_NAME': ''}.obs;
  RxMap<String, String> selectedSttMap = {'STT_ID':'', 'STT_NM': ''}.obs;
  RxList<dynamic> cmpList = [].obs;
  RxList<dynamic> sttList = [].obs;
  RxList<dynamic> productSearchList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isCheckCondition = false.obs;
  List<PlutoRow> rowDatas = [];
  late final PlutoGridStateManager gridStateMgr;

  void checkCondition() {
    textController.text == '' && selectedCmpMap['FG_NAME'] == '품명 선택'
        && selectedSttMap['STT_NM'] == '강종 선택' && textController2.text == '' ? null : isCheckCondition.value = true;
  }

  Future<void> checkButton() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR0900_R01', {'@p_WORK_TYPE':'Q', '@p_CST_NM': textController.text
        , '@p_CMP_ID': selectedCmpMap['FG_NAME'] == '품명 선택' ? '' : '${selectedCmpMap['FG_CODE']}', '@p_STT_ID': selectedSttMap['STT_NM'] == '강종 선택' ? '' : '${selectedSttMap['STT_ID']}', '@p_THIC': textController2.text == '' ? null : textController2.text}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          productSearchList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });
      Get.log('재품재고 조회 ::::::: $a');
    }catch(err) {
      Get.log('USP_MBR0900_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
      plutoRow();
    }
  }

  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(productSearchList.length, (index) =>
        PlutoRow(cells:
        Map.from((productSearchList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value:  value)),
        )))
    );
    gridStateMgr.removeAllRows();
    gridStateMgr.appendRows(rowDatas);
    gridStateMgr.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
  }


  Future<void> convert() async {
    cmpList.clear();
    sttList.clear();
    selectedCmpMap.clear();
    selectedSttMap.clear();
    selectedCmpMap.addAll({'FG_CODE':'', 'FG_NAME': '품명 선택'});
    selectedSttMap.addAll({'STT_ID':'', 'STT_NM': '강종 선택'});

    try{
      var cmpList2 = await HomeApi.to.BIZ_DATA('L_BSS028').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'FG_CODE':'', 'FG_NAME': '품명 선택'}),

        cmpList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('위치 : $cmpList2');
      /// 작업위치
      var sttList2 = await HomeApi.to.BIZ_DATA('L_PRS010').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'STT_ID':'', 'STT_NM': '강종 선택'}),
        sttList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('$sttList2');
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }

  @override
  void onInit() {
    convert();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
