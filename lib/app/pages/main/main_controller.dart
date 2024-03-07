import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  static MainController get to => Get.find();

  /// 공통 변수
  RxInt selected = 0.obs;
  RxString appBarTitle = ''.obs;

  RxBool readOnly = false.obs;
  RxString resultText = ''.obs;
  RxBool isScaning = false.obs;


  TextEditingController roomNameController = TextEditingController();

  Future<bool> requestPermission() async {
    var status = await Permission.location.request();


    switch (status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.provisional:
        return true;
    }
  }

  void changeMenu(int param) {
    if (param == 0) {
      appBarTitle.value = '';
    } else if (param == 1) {
      appBarTitle.value = '웹뷰';
    } else if (param == 2) {
      appBarTitle.value = '마이페이지';
    }

  }


  @override
  void onInit() {
    requestPermission();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}
}
