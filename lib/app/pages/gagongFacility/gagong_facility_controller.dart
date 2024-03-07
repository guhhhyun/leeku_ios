
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class GagongFacilityController extends GetxController {
  PlutoGridStateManager? gridStateMgr = null;
  RxList test = [].obs;
  RxList<String> movIds = [''].obs;
  RxList<dynamic> datasList = [].obs;
  RxList<dynamic> inspChList = [].obs;
  RxList<dynamic> callCarList = [].obs;
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxList fkfNoList = [''].obs; // 위치 정보 리스트
  RxString selectedFkf = '선택해주세요'.obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxBool registButton = false.obs;
  RxBool isLoading = false.obs;
  RxBool isCheck = false.obs;
  RxInt choiceButtonVal = 3.obs;
  RxString movCd = ''.obs;
  RxString inspCh = ''.obs;
  RxString callCar = ''.obs;
  List<PlutoRow> rowDatas = [];




  Future<void> checkButton() async {
    inspChList.clear();
    callCarList.clear();
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBS1700_R01', {'@P_WORK_TYPE':'Q', '@P_ST_DT': '$dayStartValue'
        , '@P_END_DT': '$dayEndValue', '@P_INSP_CHK': inspCh.value, '@P_CALL_CAR': callCar.value}).then((value) =>
      {
        datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
        for(var i = 0; i < datasList.length; i++) {
          inspChList.add(''),
          callCarList.add(''),
        }
      });
    }catch(err) {
      Get.log('USP_MBS0600_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
      plutoRow();
    }
  }



  Future<void> saveButton(int index) async {
    var a = await HomeApi.to.PROC('USP_MBS1700_S01', {'@p_WORK_TYPE':'U', '@P_SCALE_ID': '${datasList[index]['C_SCALE_ID']}', '@P_INSP_CHK': inspChList[index], '@P_CALL_CAR': callCarList[index], '@p_USER':Utils.getStorage.read('userId')});

    Get.log('가공설 저장: $a');
  }


  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(datasList.length, (index) =>
        PlutoRow(cells:
        Map.from((datasList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value: value ==  null || value == 'N' ? '' : key == 'C_WGT_DATE' ? value.toString().substring(0, 4) + '-' + value.toString().substring(4, 6) + '-' + value.toString().substring(6, 8):key == 'INSP_CHK' ? 'V' :  key == 'CALL_CAR' ? 'V' : value )),
        )))
    );
    gridStateMgr?.removeAllRows();
    gridStateMgr?.appendRows(rowDatas);
    gridStateMgr?.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
  }




  @override
  void onInit() async {
    checkButton();

  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
