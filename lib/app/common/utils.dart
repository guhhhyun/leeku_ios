import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static final getStorage = GetStorage();


  static void showToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        // timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 0, 36, 82),
        textColor: Colors.white,
        fontSize: 16);
  }

  static void gErrorMessage(String msg, {String? title = '알림'}) {
    if (false == Get.isOverlaysOpen) {
      Get.showSnackbar(GetSnackBar(
        title: title,
        message: msg,
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 5,
      ));
    }
  }


}
