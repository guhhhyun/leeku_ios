import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController with GetTickerProviderStateMixin {
  GlobalService gs = Get.find();

  RxBool isLoading = false.obs;
  RxList<dynamic> noticeList = [].obs;
  RxList<dynamic> alarmNList = [].obs;

  Future<void> reqNoticeList() async {
    var a = await HomeApi.to.PROC('USP_MBR0100_R01',
        {'@p_WORK_TYPE': 'Q'}).then((value) =>
    {
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        noticeList.value = value['RESULT']['DATAS'][0]['DATAS'],
      }
    });
    Get.log('공지사항 ::::: ${noticeList.value}');
  }

  Future<void> reqListAlarm() async {

    alarmNList.clear();
    try{
      isLoading.value = true;
      var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"Q_LIST","@p_RCV_USER":Utils.getStorage.read('userId'),"@p_CHK_YN": ''/*,"@p_TYPE_MSG":''*/}).then((value) =>
      {
        alarmNList.value = value['RESULT']['DATAS'][0]['DATAS'],

      });
      Get.log('알림 조회::::::::: $a');
    }catch(err) {
      Get.log('PS_PERIOD_USR_MSG err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally{
      isLoading.value = false;
    }

  }
  RxList<dynamic> allList = [].obs;
  RxList<int> datasList = [0].obs;

/*
  Future<void> req() async {
    try{
      allList.clear();
      datasList.clear();
      isLoading.value = true;
      var a = await HomeApi.to.PROC("USP_MBR0000_R01", {"@p_WORK_TYPE":"MENU","@p_USER_ID":Utils.getStorage.read('userId')}).then((value) =>
      {
        allList.value = value['DATAS'],
        for(var i = 0; i < allList.length; i++) {
          datasList.add(value['DATAS'][i]['SORT_SEQ']),
        }
      });
      Get.log('권한 조회::::::::: ${datasList.value}');
      Get.log('권한 조회::::::::: ${datasList.contains(300)}');
    }catch(err) {
      Get.log('USP_MBR0000_R01 err = ${err.toString()} ', isError: true);
    //  Utils.gErrorMessage('네트워크 오류');
    }finally{
      isLoading.value = false;
    }

  }
*/
  void userLeft() async {
    String status = await HomeApi.to.LOGIN_MOB(Utils.getStorage.read('userId'), Utils.getStorage.read('userPw'));
    Get.log('로그인~~~~~~~~~~~~~~~~~~~~ $status');
    status == 'SUCCESS' ? null : gs.logout();
  }



  @override
  void onInit() async{
    userLeft();
    reqNoticeList();
    reqListAlarm();
  }

  @override
  void onClose() {}

  @override
  void onReady() async{
    reqListAlarm();
  }
}
