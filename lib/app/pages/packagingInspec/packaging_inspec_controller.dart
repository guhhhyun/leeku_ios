
import 'dart:io';

import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class PackagingInspecController extends GetxController {

  var textController = TextEditingController();
  RxList<dynamic> productList = [].obs;
  RxList<dynamic> productDetailList = [].obs;
  RxList<dynamic> productDetailRealList = [].obs;
  RxList<dynamic> inspecDetailList = [].obs;
  RxString barcodeScanResult = ''.obs;
  RxDouble realWeight = 0.0.obs;
  RxDouble totalWeight = 0.0.obs;
  RxDouble jigwan = 0.0.obs;
  RxList<bool> isProductSelectedList = [false].obs;
  RxList productSelectedList = [].obs;
  RxInt focusCnt = 0.obs;

  Future<void> saveButton() async {
    for(var i = 0; i < productSelectedList.length; i++) {
      await HomeApi.to.PROC('USP_MBS1300_S01',
          {'@p_WORK_TYPE': 'U', '@p_BARCODE_NO': productSelectedList[i]['BARCODE'], '@p_USER': Utils.getStorage.read('userId')});
      Get.log('검수완료 ::::: $i 번째');
    }
    checkButton();
    checkButton2();
    checkButton3();
  }

  Future<void> checkButton() async {
    productList.clear();
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        productList.value = value['RESULT']['DATAS'][0]['DATAS'],
      }
    });
    Get.log('포장검수 첫번째: $a');
  }
  Future<void> checkButton2() async {
    productSelectedList.clear();
    productDetailList.clear();
    productDetailRealList.clear();
    isProductSelectedList.clear();
    realWeight.value = 0.0;
    totalWeight.value = 0.0;
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q1', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        productDetailList.value = value['RESULT']['DATAS'][0]['DATAS'],
      },
      for(var i = 0; i < productDetailList.length; i++) {
        if(productDetailList[i]['SPEC_YN'] == 'N') {
          productDetailRealList.add(productDetailList[i])
        },
      },
      for(var i = 0; i < productDetailRealList.length; i++) {
        productSelectedList.add(productDetailRealList[i]),
        realWeight.value = realWeight.value + productDetailRealList[i]['REAL_WEIGHT'],
        totalWeight.value = totalWeight.value + productDetailRealList[i]['ALL_WEIGHT'],
        if(productDetailRealList[i]['JIGWAN'] == null) {
          productDetailRealList[i]['JIGWAN'] = 0
        },
        isProductSelectedList.add(true),
        if(productDetailRealList[i]['JIGWAN'] != '') {
          jigwan.value = jigwan.value + double.parse(productDetailRealList[i]['JIGWAN'].toString()),
        }
      }
    });
    Get.log('포장검수 두번째: $a');
  }
  Future<void> checkButton3() async {
    inspecDetailList.clear();
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q2', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        inspecDetailList.value = value['RESULT']['DATAS'][0]['DATAS'],
      }
    });
    Get.log('포장검수 세번째: $a');
  }

  @override
  void onInit() {
    checkButton();

  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
