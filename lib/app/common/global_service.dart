import 'dart:async';

import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../net/home_api.dart';
import '../net/http_util.dart';
import '../routes/app_route.dart';

class GlobalService extends GetxService {

  static GlobalService get to => Get.find();
  String authToken = '';
  RxBool isLogin = false.obs;
  var loginId = ''.obs;
  var loginPassword = ''.obs;
  var loginNm = ''.obs;

  // var userInfo = UserModel();

   /// 로그인 정보 불러오기
   void loadLoginInfo() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (Utils.getStorage.hasData('userId') &&
           Utils.getStorage.hasData('userPw')) {
          isLogin.value = true;
          loginId.value = Utils.getStorage.read('userId');
          loginPassword.value = Utils.getStorage.read('userPw');
          await prefs.setString('userId', Utils.getStorage.read('userId'));
         String status = await HomeApi.to.LOGIN_MOB(Utils.getStorage.read('userId'), Utils.getStorage.read('userPw'));
         Get.log('로그인~~~~~~~~~~~~~~~~~~~~ $status');
         status == 'SUCCESS' ? null : logout();


       }else {
        isLogin.value = false;
        Get.toNamed(Routes.LOGIN_PAGE);
      }
     } catch (err) {
       Get.log('GlobalService - onInit Err ', isError: true);
       Get.log(err.toString(), isError: true);
     } finally {
    }
   }

  void setLoginInfo({required String id, required String password}) async {
    try {
      loginId.value = id;
      loginPassword.value = password;

      await Utils.getStorage.write('userId', loginId.value);
      await Utils.getStorage.write('userPw', loginPassword.value);

    } catch (err) {
      Get.log('GlobalService - setLoginInfo Err ', isError: true);
      Get.log(err.toString(), isError: true);
    } finally {
      await req();
    }
  }


  void logout() async {
    await Utils.getStorage.erase();
    isLogin.value = false;
    loginId.value = '';
    loginPassword.value = '';
    loginNm.value = '';
    Get.toNamed(Routes.LOGIN_PAGE);
    Utils.gErrorMessage('로그아웃');

  }
  RxList<dynamic> allList = [].obs;
  RxList<int> datasList = [0].obs;
  RxBool isLoading = false.obs;
  Future<void> req() async {
    try{
      allList.clear();
      datasList.clear();
      isLoading.value = true;
      var a = await HomeApi.to.PROC("USP_MBR0000_R01", {"@p_WORK_TYPE":"MENU","@p_USER_ID":Utils.getStorage.read('userId')}).then((value) =>
      {
        Get.log('시발 $value'),
        allList.value = value['RESULT']['DATAS'][0]['DATAS'],
        for(var i = 0; i < allList.length; i++) {
          datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]['SORT_SEQ']),
        }
      });
      Get.log('권한 조회::::::::: ${datasList.value}');
      Get.log('권한 조회::::::::: ${datasList.contains(300)}');
    }catch(err) {
      Get.log('USP_MBR0000_R01 err = ${err.toString()} ', isError: true);
      //  Utils.gErrorMessage('네트워크 오류');
    }finally{
      isLoading.value = false;
      Get.toNamed(Routes.MAIN);
    }

  }

  @override
  void onClose() {
    Get.log('GlobalService - onClose !!');

    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('GlobalService - onInit !!');
    loadLoginInfo();
    req();
    super.onInit();
  }

  @override
  void onReady() {
    Get.log('GlobalService - onReady !!');
  }
}