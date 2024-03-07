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


class GongjungCheckController extends GetxController {

  var textController = TextEditingController(); // 거래처명
  var textController2 = TextEditingController(); // 두께

  RxMap<String, String> selectedCmpMap = {'FG_CODE':'', 'FG_NAME': ''}.obs;
  RxMap<String, String> selectedSttMap = {'STT_ID':'', 'STT_NM': ''}.obs;
  RxList<dynamic> cmpList = [].obs;
  RxList<dynamic> sttList = [].obs;
  RxList<dynamic> processList = [].obs;
  RxList<dynamic> processDetailList = [].obs;
  RxBool isLoading = false.obs;
  RxString gubunCd = '1'.obs;
  RxList selectedContainer = [].obs;
  List<PlutoRow> rowDatas = [];
  List<PlutoRow> rowDatasDetail = [];
  late final PlutoGridStateManager gridStateMgr;
  late PlutoGridStateManager gridStateMgr2;


  Future<void> checkButton() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR0800_R02', {'@p_WORK_TYPE':'Q', '@p_CPY_ID': gubunCd.value
        , '@p_CST_NAME': textController.text, '@p_CMP_NM': selectedCmpMap['FG_NAME'] == '품명 선택' ? '' : '${selectedCmpMap['FG_NAME']}', '@p_STT_NM': selectedSttMap['STT_NM'] == '강종 선택' ? '' : '${selectedSttMap['STT_NM']}', '@p_DUKE': textController2.text == '' ? '' : textController2.text}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          processList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });
      Get.log('공정조회 ::::::: $a');
    }catch(err) {
      Get.log('USP_MBR0800_R02 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
      plutoRow();
    }
  }

  Future<void> detailCheckList() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR0800_R03', {'@p_WORK_TYPE':'Q', '@p_CARD_LIST_NO': '${selectedContainer[0]['CARD_LIST_NO']}'
        , '@p_COIL_ID': '${selectedContainer[0]['COIL_ID']}'}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          processDetailList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });
      Get.log('상세공정 ::::::: $a');
    }catch(err) {
      Get.log('USP_MBR0800_R03 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
      plutoRow2();
    }
  }
  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(processList.length, (index) =>
        PlutoRow(cells:
        Map.from((processList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value: value)),
        )))
    );
    gridStateMgr.removeAllRows();
    gridStateMgr.appendRows(rowDatas);
    gridStateMgr.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
  }

  Future<void> plutoRow2() async {

    rowDatasDetail = List<PlutoRow>.generate(processDetailList.length, (index) =>
        PlutoRow(cells:
        Map.from((processDetailList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value: value)),
        )))
    );
    gridStateMgr2.removeAllRows();
    gridStateMgr2.appendRows(rowDatasDetail);
    gridStateMgr2.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
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
    checkButton();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
    checkButton();
  }
}
