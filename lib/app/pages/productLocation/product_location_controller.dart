import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProductLocationController extends GetxController {
  var textController = TextEditingController();

  RxInt focusCnt = 0.obs;
  RxString textBc = ''.obs;
  RxList productList = [].obs; // 제품 정보
  RxList<dynamic> locationList = [].obs; // 위치 정보 리스트
  RxList locationCdList = [''].obs; // 위치 정보 리스트
  RxString selectedLocation = '선택해주세요'.obs;
  RxMap<String, String> selectedLocationMap = {'RACK_BARCODE':'', 'AREA': ''}.obs;
  RxBool isButton = false.obs;
  RxBool isBcCode = false.obs;
  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs;
  RxBool isAreaScan = false.obs;
  RxList bcList = [].obs;


  Future<void> checkButton() async {
    try{
      var a = await HomeApi.to.PROC('USP_MBS0400_R01',
          {'@p_WORK_TYPE': 'Q', '@p_BARCODE_NO': textBc.value}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          productList.value = value['RESULT']['DATAS'][0]['DATAS'],
          for(var i = 0; i < productList.length; i++ ) {
            bcList.add(productList[i]['BARCODE_NO'])
          },
          Get.log('ku ${bcList}')
          /*if(value['DATAS']['BARCODE_NO'] != null) {
            isBcCode.value = true
          }else {
            isBcCode.value = false
          }*/
        }
      });
      Get.log('바코드 조회 쿼리: $a');
      if(productList.isNotEmpty) {
        isBcCode.value = true;
      }else {
        isBcCode.value = false;
      }
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }

  /// 수정 필요 user 고정값 빼고 p_RACK_BARCODE도 여쭤보고 수정
  Future<void> saveButton(int index) async {
    var a = await HomeApi.to.PROC('USP_MBS0400_S01', {'@p_WORK_TYPE':'U', '@p_BARCODE_NO': bcList[index]
      , '@p_RACK_BARCODE':selectedLocationMap['RACK_BARCODE'], '@p_USER':Utils.getStorage.read('userId')});
    Get.log('이동 결과: ${a}');
  }

  Future<void> loactionConvert() async {

    locationList.clear();
    selectedLocationMap.clear();
    selectedLocationMap.addAll({'RACK_BARCODE':'', 'AREA': '선택해주세요'});
    try{
      var location = await HomeApi.to.BIZ_DATA('L_BSS030').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'RACK_BARCODE':'', 'AREA': '선택해주세요'}),
        locationList.value = value['RESULT']['DATAS'][0]['DATAS'],

      });
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

    Get.log('위치 : $locationList');
  }



    @override
  void onInit() {
      loactionConvert();
    }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
