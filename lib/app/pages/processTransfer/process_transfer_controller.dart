
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget_callback_dispatcher.dart';
import 'package:intl/intl.dart';


class ProcessTransferController extends GetxController {
  RxList test = [].obs;
  RxList<String> movIds = [''].obs;
  RxList<dynamic> processList = [].obs;
  RxList<bool> isprocessSelectedList = [false].obs;
  RxList<dynamic> processSelectedList = [].obs;
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 3))).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxList<String> movYnList = ['전체','처리','미처리'].obs;
  RxString selectedMovYn = '미처리'.obs;
  RxString selectedMovYnCd = 'N'.obs; // 처리: y, 미처리: n
  RxMap<String, String> selectedFkfNm = {'FKF_NO':'', 'FKF_NM': ''}.obs;
  RxMap<String, String> selectedSaveFkfNm = {'FKF_NO':'', 'FKF_NM': ''}.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList fkfNoList = [''].obs; // 위치 정보 리스트
  RxString selectedFkf = '선택해주세요'.obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxList<dynamic> fkfList = [].obs;
  RxList<dynamic> machList = [].obs;
  RxBool registButton = false.obs;
  RxBool isLoading = false.obs;

  Future<void> checkButton() async {
    movIds.clear();
    isprocessSelectedList.clear();
    processSelectedList.clear();
    processList.clear();

    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBS0600_R01', {'@p_WORK_TYPE':'Q', '@p_DATE_FR': '$dayStartValue'
        , '@p_DATE_TO': '$dayEndValue', '@p_MOV_YN':'$selectedMovYnCd', '@p_FKF_NO':selectedFkfNm['FKF_NO'], '@p_FROM_MACH': selectedMachMap['MACH_CODE']}).then((value) =>
      {
        for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
          isprocessSelectedList.add(false)
        },
        processList.value = value['RESULT']['DATAS'][0]['DATAS'],
        Get.log('aa ${processList.value}')

      });
    }catch(err) {
      Get.log('USP_MBS0600_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
    }
  }



  Future<void> loactionConvert() async {
    fkfList.clear();
    machList.clear();
    selectedFkfNm.clear();
    selectedSaveFkfNm.clear();
    selectedMachMap.clear();
    selectedSaveFkfNm.addAll({'FKF_NO':'', 'FKF_NM': '지게차 선택'});
    selectedFkfNm.addAll({'FKF_NO':'', 'FKF_NM': '지게차 선택'});
    selectedMachMap.addAll({'MACH_CODE':'', 'MACH_NAME': '설비 선택'});

    try{
      var fkfList2 = await HomeApi.to.BIZ_DATA('L_BSS032').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'FKF_NO':'', 'FKF_NM': '지게차 선택'}),

        fkfList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('위치 : $fkfList2');
      /// 작업위치
      var engineer = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'MACH_CODE':'', 'MACH_NAME': '설비 선택'}),
        machList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('$engineer');
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }

  Future<void> saveButton(int index) async {
    var a = await HomeApi.to.PROC('USP_MBS0600_S01', {'@p_WORK_TYPE':'U', '@p_MOV_ID': movIds[index] // 리스트로는 안들어감.
      , '@p_FKF_NO': selectedSaveFkfNm['FKF_NO'], '@p_MOV_YN':'Y', '@p_USER':Utils.getStorage.read('userId')});

    Get.log('공정이동 저장: $a');
  }


  @override
  void onInit() async {
    loactionConvert();
    await HomeApi.to.PROC('USP_MBS0600_R01', {'@p_WORK_TYPE':'Q', '@p_DATE_FR': '$dayStartValue'
      , '@p_DATE_TO': '$dayEndValue', '@p_MOV_YN':'$selectedMovYnCd', '@p_FKF_NO':selectedFkfNm['FKF_NO'], '@p_FROM_MACH': selectedMachMap['MACH_CODE']}).then((value) =>
    {
      for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
        isprocessSelectedList.add(false)
      },
      processList.value = value['RESULT']['DATAS'][0]['DATAS'],
      Get.log('aa ${processList.value}')

    });
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
