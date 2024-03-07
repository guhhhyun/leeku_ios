

import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  RxList<dynamic> alarmAllList = [].obs;
  RxList<dynamic> alarmYList = [].obs;
  RxList<dynamic> alarmNList = [].obs;
  RxList<dynamic> alarmBizList = [].obs;
  RxList<dynamic> isAlarmList = [].obs;

  RxString chkYn = ''.obs;
  RxInt tabIdx = 0.obs;
  GlobalService gs = Get.find();
  RxBool isLoading = false.obs;
  RxBool loadingEnd = false.obs;
  RxString chkDtmNew = ''.obs;

  RxString TYPE_MSG_NM = ''.obs;
  RxString TEXT_TG = ''.obs;
  RxString ACT_DTM = ''.obs;
  RxString TEXT_CT = ''.obs;
  RxString CHK_DTM = ''.obs;
  RxString REQ_USER_NM = ''.obs;
  RxString WRK_DEPT_NM = ''.obs;


   Future<void> bizData() async {
     var alarm = await HomeApi.to.BIZ_DATA('L_PN001').then((value) =>
     {
       alarmBizList.value = value['RESULT']['DATAS'][0]['DATAS'],
     });
     Get.log('알람 :  :  ${alarmBizList.value}');
   }

/*  Future<void> checkFinishList(int index) async {
    var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"U_CHK","@p_RCV_USER":gs.loginId.value,"@p_ID":alarmList[index]["ID"]}).then((value) =>
    {

    });
    Get.log('알림 조회::::::::: $a');

  }*/

  Future<void> reqListAlarm() async {
    alarmAllList.clear();
    alarmYList.clear();
    alarmNList.clear();
    isAlarmList.clear();
    try{
      isLoading.value = true;
      var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"Q_LIST","@p_RCV_USER":Utils.getStorage.read('userId'),"@p_CHK_YN": chkYn.value/*,"@p_TYPE_MSG":''*/}).then((value) =>
      {
        chkYn.value == '' ?
        alarmAllList.value = value['RESULT']['DATAS'][0]['DATAS'] :  chkYn.value == 'Y' ? alarmYList.value = value['RESULT']['DATAS'][0]['DATAS'] : alarmNList.value = value['RESULT']['DATAS'][0]['DATAS'],
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
            chkYn.value == '' ?
            isAlarmList.add(alarmAllList[i]["CHK_YN"]) : chkYn.value == 'Y' ?  isAlarmList.add(alarmYList[i]["CHK_YN"]) : isAlarmList.add(alarmNList[i]["CHK_YN"])
          },
        },
      });
      Get.log('알림 조회::::::::: $a');
    }catch(err) {
      Get.log('PS_PERIOD_USR_MSG err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally{
     isLoading.value = false;
    }

  }





  @override
  void onClose() {
    Get.log('AlarmController - onClose !!');
    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('AlarmController - onInit !!');
    super.onInit();
    bizData();
    reqListAlarm();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    Get.log('AlarmController - onReady !!');

  }
}
