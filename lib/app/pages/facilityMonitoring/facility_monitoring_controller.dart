
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pluto_grid/pluto_grid.dart';


class FacilityMonitoringController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '400', '600'].obs;
  RxString selectedLine = '선택해주세요'.obs;
  RxString selectedLineCd = '600'.obs;
  RxList<dynamic> monitoringList = [].obs;
  RxBool isLoading = false.obs;
  List<PlutoRow> rowDatas = [];
  PlutoGridStateManager? gridStateMgr = null;


  Future<void> checkButton() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR1000_R01', {'@p_WORK_TYPE':'Q', '@p_LINE':selectedLineCd.value}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          monitoringList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });
    }catch (err) {
      Get.log('USP_MBR1000_R01 @p_WORK_TYPE Q err = ${err.toString()} ', isError: true);
    }finally {
      isLoading.value = false;
      plutoRow();
    }
  }

  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(monitoringList.length, (index) =>
        PlutoRow(cells:
        Map.from((monitoringList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value: value ?? '')),
        )))
    );
    gridStateMgr?.removeAllRows();
    gridStateMgr?.appendRows(rowDatas);
    gridStateMgr?.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
  }


  @override
  void onInit() async{
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR1000_R01', {'@p_WORK_TYPE':'Q', '@p_LINE':selectedLineCd.value}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          monitoringList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });
    }catch(err) {
      Get.log('USP_MBR1000_R01 @p_WORK_TYPE Q err = ${err.toString()} ', isError: true);
    }finally {
      isLoading.value = false;
      plutoRow();
    }

  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
