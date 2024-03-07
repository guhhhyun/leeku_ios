import 'package:egu_industry/app/common/common_confirm_widget.dart';
import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/home_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';

import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';

class LoginController extends GetxController {
  RxBool isCheckBox = false.obs;
  var idTextController = TextEditingController();
  var pwTextController = TextEditingController();
  RxBool isLogin = false.obs;

  GlobalService gs = Get.find();

  // late PackageInfo packageInfo;
  RxString strersion = '0.0.0'.obs;


  void checkBoxBtnTrue() {
    isCheckBox.value = true;
    Get.log('아이디 저장!!!');
  }

  void checkBoxBtnFalse() {
    isCheckBox.value = false;
  }

  void btnLogin() async {
    try {
      Get.log('로그인 버튼 클릭');
      String status = await HomeApi.to.LOGIN_MOB(idTextController.text, pwTextController.text);
      Get.log('${status}');
      if(status.contains('SUCCESS')) {
        isLogin.value = true;
        gs.setLoginInfo(id: idTextController.text, password: pwTextController.text);
        Get.offAllNamed(Routes.MAIN);
        Utils.gErrorMessage('로그인');

      }else if(status == 'USER NOT FOUND') {
        Utils.gErrorMessage('등록되지않은 아이디입니다. 다시 입력해주세요');
        isLogin.value = false;
      }else {
        Utils.gErrorMessage('로그인 실패. 다시 입력해주세요');
        isLogin.value = false;
      }

    } catch (e) {
      Get.log('btnLogin catch !!!!');
      Get.log(e.toString());
    } finally {
     /* gs.setLoginInfo(id: idTextController.text, password: pwTextController.text);
      Get.offAllNamed(Routes.MAIN);*/
    }
  }




  @override
  void onClose() {
    Get.log('LoginController - onClose !!');
    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('LoginController - onInit !!');

    super.onInit();
  }

  @override
  void onReady() {
    Get.log('LoginController - onReady !!');
    super.onReady();
    if (Get.arguments != null) {
      var msg = Get.arguments['msg'] ?? false;

      if (msg == true) {
        Utils.showToast(msg: '로그인이 필요한 서비스 입니다.');
      }
    }
  }
}
