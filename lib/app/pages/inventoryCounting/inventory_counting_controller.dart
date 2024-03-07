import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class InventoryCountingController extends GetxController {
  var textController = TextEditingController();

  RxList<TextEditingController> controllers = <TextEditingController>[].obs;

  RxInt focusCnt = 0.obs;
  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue =  DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxBool bSelectedDayFlag = false.obs;
  RxBool isShowCalendar = false.obs;
  RxList productList = [].obs; // 제품 정보
  RxList<dynamic> locationList = [].obs; // 위치 정보 리스트
  RxList locationCdList = [''].obs; // 위치 정보 리스트
  RxString selectedLocation = '선택해주세요'.obs;
  RxMap<String, String> selectedCheckLocationMap = {'DETAIL_CD':'', 'DETAIL_NM': ''}.obs;
  RxMap<String, String> selectedSaveLocationMap = {'DETAIL_CD':'', 'DETAIL_NM': ''}.obs;
  RxBool isButton = false.obs;
  RxList<dynamic> machList = [].obs;

  RxString dateValue2 = ''.obs;
  RxString dateValue3 = ''.obs;
  RxString dateValue4 = ''.obs;
  RxString dateValue5 = ''.obs;

  RxList<dynamic> dateList2 = [].obs;
  RxList<dynamic> dateList3 = [].obs;
  RxList<dynamic> dateList4 = [].obs;
  RxList<dynamic> dateList5 = [].obs;

  RxMap<String, String> selectedMachMap = {'CMH_ID':'', 'CMH_NM': '설비 선택'}.obs;




  /// 수정 필요 user 고정값 빼고 p_RACK_BARCODE도 여쭤보고 수정 /////// 바코드 유효성 검사도 여쭤봐야함
  Future<void> saveButton() async {
   var a = await HomeApi.to.PROC('USP_MBS0500_S01', {'@p_WORK_TYPE':'N', '@p_BARCODE_NO': textController.text,
    '@p_DATE': selectedCheckLocationMap['DETAIL_CD'] == '2' ? dateValue2.value : selectedCheckLocationMap['DETAIL_CD'] == '3'
        ? dateValue3.value : selectedCheckLocationMap['DETAIL_CD'] == '4' ? dateValue4.value : dateValue5.value,
   '@p_STK_GB':'${selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': selectedCheckLocationMap['DETAIL_CD'] == '4' ? selectedMachMap['CMH_ID'] : '', '@p_USER':Utils.getStorage.read('userId')});
   Get.log('구구ㅜ : $a');
  }

  Future<void> updateButton() async {
    for(var i = 0; i < productList.length; i++) {
     if(double.parse(controllers[i].text) != double.parse(productList[i]['C04'].toString())) {
       var a = await HomeApi.to.PROC('USP_MBS0500_S01', {'@p_WORK_TYPE':'U',
         '@p_WHT': controllers[i].text, '@p_STK_GB': productList[i]['STK_GB'], '@p_DATE': productList[i]['STK_DT']
         , '@p_CMH_ID': productList[i]['CMH_ID'], '@p_BARCODE_NO': productList[i]['SCAN_NO'],'@p_USER':Utils.getStorage.read('userId')});
     }
    }
    Get.log('중량수정 클릭!');
    Get.log('중량수정 클릭!');
  }

  Future<void> loactionConvert() async {
    machList.clear();
  //  selectedMachMap.addAll({'CMH_ID':'', 'CMH_NM': '설비 선택'});
    locationList.clear();
    selectedSaveLocationMap.clear();
    selectedCheckLocationMap.clear();

    try{
      var location = await HomeApi.to.BIZ_DATA('L_BSS035').then((value) =>
      {
        selectedCheckLocationMap['DETAIL_CD'] =  value['RESULT']['DATAS'][0]['DATAS'][0]['DETAIL_CD'],
        selectedCheckLocationMap['DETAIL_NM'] =  value['RESULT']['DATAS'][0]['DATAS'][0]['DETAIL_NM'],
        locationList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('위치 : $locationList');
      var mach = await HomeApi.to.BIZ_DATA('L_MACH_002').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CMH_ID':'', 'CMH_NM': '설비 선택'}),
        machList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      /// 스크랩
      var date1 = await HomeApi.to.BIZ_DATA('L_STK001').then((value) =>
      {
        dateValue2.value = value['RESULT']['DATAS'][0]['DATAS'][0]['STK_DT'],
        dateList2.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('dateList1 : $dateList2');
      /// 슬라브
      var date2 = await HomeApi.to.BIZ_DATA('L_STK002').then((value) =>
      {
        dateValue3.value = value['RESULT']['DATAS'][0]['DATAS'][0]['STK_DT'],
        dateList3.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      /// 재공
      var date3 = await HomeApi.to.BIZ_DATA('L_STK003').then((value) =>
      {
        dateValue4.value = value['RESULT']['DATAS'][0]['DATAS'][0]['STK_DT'],
        dateList4.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      /// 반제품
      var date4 = await HomeApi.to.BIZ_DATA('L_STK004').then((value) =>
      {
        dateValue5.value = value['RESULT']['DATAS'][0]['DATAS'][0]['STK_DT'],
        dateList5.value = value['RESULT']['DATAS'][0]['DATAS']
      });
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }
  }

 /* Future<void> dateDropDown(String gb) async {

    /// 스크랩
    var date1 = await HomeApi.to.BIZ_DATA('L_STK001').then((value) =>
    {
      dateList1.value = value['RESULT']['DATAS'][0]['DATAS']
    });
    /// 슬라브
    var date2 = await HomeApi.to.BIZ_DATA('L_STK002').then((value) =>
    {
      dateList2.value = value['RESULT']['DATAS'][0]['DATAS']
    });
    /// 재공
    var date3 = await HomeApi.to.BIZ_DATA('L_STK003').then((value) =>
    {
      dateList3.value = value['RESULT']['DATAS'][0]['DATAS']
    });
    /// 반제품
    var date4 = await HomeApi.to.BIZ_DATA('L_STK004').then((value) =>
    {
      dateList4.value = value['RESULT']['DATAS'][0]['DATAS']
    });

  }*/



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
