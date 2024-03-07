import 'dart:convert';

import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_detail_page.dart';
import 'package:egu_industry/app/pages/processTransfer/process_transfer_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_bluetooth_printer/flutter_simple_bluetooth_printer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class ScrapLabelController extends GetxController {
  var textController = TextEditingController();
  var weighingTextController = TextEditingController(); // 계근중량
  var qtyTextController = TextEditingController(); // 수량
  var partWeiTextController = TextEditingController(); // 단위중량
  var weighingInfoTextController = TextEditingController(); // 계량정보
  var otherScrapTextController = TextEditingController(); // 외주스크랩
  var searchDropTextController = TextEditingController(); // 설통검색
  RxBool isLabelBtn = false.obs; // 라벨 발행
  RxBool test1 = false.obs;
  RxBool isFirstDuplication = false.obs;
  RxBool isClearDuplication = false.obs;
  RxBool isSecondDuplication = false.obs;


  RxBool isPrinting = false.obs;
  RxInt focusCnt = 0.obs;
  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs; /// 외주 스크랩
  RxString barcodeScanResult2 = '바코드를 스캔해주세요'.obs; /// 계량정보
  RxMap<String, String> selectedIndustryMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScrapNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedRmNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScLocMap = {'RACK_BARCODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedTareMap = {'CODE':'', 'NAME': '', 'WEIGHT': ''}.obs;
  RxList<dynamic> industryList = [].obs;
  RxList<dynamic> scrapNmList = [].obs;
  RxList<dynamic> rmNmList = [].obs;
  RxList<dynamic> scLocList = [].obs;
  RxList<dynamic> tareList = [].obs;
  RxList<dynamic> measList = [].obs;
  RxList<dynamic> outScrapList = [].obs;
  RxList<String> scrapGubunList = ['스크랩', '지금류'].obs; // 하드코딩 하는건가 흠
  RxString selectedGubun = '스크랩'.obs;
  RxList<String> scrapTypeList = ['매입', '공정회수', '외주'].obs;
  RxString selectedScrapType = '매입'.obs;
  RxString selectedScrapTypeCd = ''.obs;
  RxList<String> goldList = ['베어제', '도금', '박리'].obs;
  RxString selectedGold = '베어제'.obs;
  RxString selectedGoldCd = ''.obs;
  RxList meansNumList = [].obs;
  RxBool isCheck = false.obs;
  RxString matlGb = ''.obs;
  RxString scrapFg = ''.obs;
  int resultRowCount = 0;
  String returnMessage = '';
  RxString scrapNo = ''.obs;
  RxBool isChoiceSheet = false.obs;
  RxList<dynamic> realLabelData = [].obs;
  RxList<dynamic> popUpDataList = [].obs;
  RxList<bool> selectedPopList = [false].obs;
  RxList selectedContainer = [].obs;
  RxString startValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString endValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxBool isEndLabel = false.obs; // 재발행 여부 판단





  Future<void> popUpData() async {
    try{
      var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SCALE2', '@p_DATE_FROM': startValue.value.replaceAll('-', ''), '@p_DATE_TO': endValue.value.replaceAll('-', '') }).then((value) => // pop
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++){
            popUpDataList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
          },
        },
      });
      Get.log('계량정보 선택::::: $a');
      Get.log('계량정보 선택2::::: $popUpDataList');
    }catch(e) {
      Utils.gErrorMessage('네트워크 오류');
      print(e);
    }
  }

  Future<void> convert() async {
    selectedIndustryMap.clear();
    selectedIndustryMap.addAll({'CODE':'', 'NAME': '선택해주세요'});

    try{
      var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_PROC'}).then((value) => // 공정정보
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
        industryList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });
      Get.log('공장정보::::: $a');
      selectedScrapNmMap.clear();
      selectedScrapNmMap.addAll({'CODE':'', 'NAME': '선택해주세요'});
      var b = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_ITEM', '@p_WHERE1':'SC'}).then((value) => // 스크랩품명
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
        scrapNmList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });
      Get.log('스크랩품명::::: $b');
      selectedRmNmMap.clear();
      selectedRmNmMap.addAll({'CODE':'', 'NAME': '선택해주세요'});
      var c = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_ITEM', '@p_WHERE1':'RM'}).then((value) => // 지금류품명
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
        rmNmList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });

      Get.log('지금류품명::::: $c');
      selectedTareMap.clear();
      selectedTareMap.addAll({'CODE':'', 'NAME': '설통번호 선택', 'WEIGHT': ''});
      var d = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SLT'}).then((value) => // 설통번호
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'NAME': '설통번호 선택', 'WEIGHT':'' }),
        tareList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });
      Get.log('설통번호::::: $d');
    }catch(e) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }


  void checkLogic() {
    try{
      if(selectedGubun.value == '지금류') {
        if( selectedRmNmMap['NAME'] != '선택해주세요' && selectedScLocMap['NAME'] != '선택해주세요'
            && qtyTextController.text != '' && partWeiTextController.text != ''){
          isLabelBtn.value = true;
        }else {
          isLabelBtn.value = false;
        }
      }else if(selectedGubun.value == '스크랩') {
        if(selectedGold.value == '도금') {
          selectedGoldCd.value = '1';
          scrapFg.value = 'F1';
        }else if(selectedGold.value == '박리'){
          selectedGoldCd.value = '2';
          scrapFg.value = 'FF';
        }else {
          selectedGoldCd.value = '0';
          if(selectedScrapType.value == '외주') {
            scrapFg.value = '${outScrapList[0]['SCRAP_FG']}';
          }else if(selectedScrapType.value == '매입') {
            scrapFg.value = 'DD';
          }else if(selectedScrapType.value == '공정회수') {
            if(selectedIndustryMap['NAME'] == '미노면삭' || selectedIndustryMap['NAME'] == '이쿠다면삭') {
              scrapFg.value = 'BB';
            }else {
              scrapFg.value = 'CC';
            }
          } else {
            Exception('scrapFg 에러!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
          }
        }


        switch(selectedScrapType.value) {
          case "매입":
            selectedScrapTypeCd.value = '1';
            if(selectedScrapNmMap['NAME'] != '선택해주세요'
                && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
            ){
              isLabelBtn.value = true;
            }else {
              isLabelBtn.value = false;
            }
            break;
          case "공정회수":
            selectedScrapTypeCd.value = '2';
            if(selectedIndustryMap['NAME'] != '선택해주세요' && selectedGold.value != '선택해주세요' && selectedScrapNmMap['NAME'] != '선택해주세요'
                && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
            ){
              isLabelBtn.value = true;
            }else {
              isLabelBtn.value = false;
            }
            break;
          case "외주":
            selectedScrapTypeCd.value = '3';
            if( selectedGold.value != '선택해주세요' && selectedScrapNmMap['NAME'] != '선택해주세요'
                && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
                && outScrapList.isNotEmpty){
              isLabelBtn.value = true;
            }else {
              isLabelBtn.value = false;
              // isLabelBtn.value //
            }
            break;
          default:
            break;
        }
      }
    }catch(err) {
      Get.log('$err');
      isFirstDuplication.value = false;
      Utils.gErrorMessage('네트워크 오류 (0)');
    }

  }
  /// 지금류
  /*EXEC USP_SCS0300_S01
  @p_WORK_TYPE = 'N_SCR', @p_MATL_GB = '구분선택값',
  @P_SCRAP_FG = 'AA' , @p_ITEM_CODE = '지금류품목코드',
  @P_CST_ID ='계량 거래처코드',@p_CST_NAME ='계량 거래처명',
  @P_MEAS_NO = '계량번호', @p_WEIGHT = 차감중량,
  @P_QTY = 수량, @p_UNIT_WEIGHT = 단위중량,
  @P_WH_NO = 'WH02',
  @p_RACK_BARCODE = '적재위치 RACK_BARCODE',
  @p_USER_ID = '로그인 사용자 ID’,
  @p_result_row_count = @p_result_row_count OUTPUT,
  @p_return_message = @p_return_message OUTPUT*/

  /// 스크랩
 /* EXEC USP_SCS0300_S01
  @p_WORK_TYPE = 'N_SCR', @p_MATL_GB = '구분선택값',
  @p_SCRAP_TYPE = '유형선택값',
  @P_SCRAP_FG = 유형이 외주 시 외주 스크랩 스캔값의 SCRAP_FG설정. 그 외 도금의 선택이 [도금]일 경우 'F1', [박리] 'FF', [무도금]일 경우 유형이 [매입]일 경우 'DD', [공정회수] 선택시 공정정보가 [미노면삭(WK220), 이쿠다면삭(WK410)] 일 경우 'BB', 그외 'CC' ,  저장 전 해당 값이 없으면 오류 발생,
  @p_ITEM_CODE = '지금류품목코드',
  @p_PROC_CODE = '공정정보 선택코드'
  @P_CST_ID ='계량 거래처코드',@p_CST_NAME ='계량 거래처명',
  @P_MEAS_NO = '계량번호', @p_PLATE_FG = '도금 선택값',
  @p_TARE_NO = '설통번호', @p_TARE_WEIGHT = 설통중량,
  @p_WEIGH_WEIGHT = 계근중량,
  @p_WEIGHT = 차감중량, @P_WH_NO = 'WH04',
  @p_RACK_BARCODE = '적재위치 RACK_BARCODE',
  @p_OUTS_NO = '외주스크랩’,
  @p_USER_ID = '로그인 사용자 ID’,
  @p_result_row_count = @p_result_row_count OUTPUT,
  @p_return_message = @p_return_message OUTPUT*/


  // 지금류 라벨발행
  Future<void> saveButton(BuildContext context) async {
    try{
      var a = await HomeApi.to.PROC('USP_MBS1200_S01', {'@p_WORK_TYPE':'N_SCR', '@p_MATL_GB': '$matlGb',
        '@p_SCRAP_FG':'AA', '@p_ITEM_CODE':'${selectedRmNmMap['CODE']}', '@p_CST_ID': weighingInfoTextController.text != '' ? selectedContainer.isNotEmpty ? selectedContainer[0]['CST_ID'] == null ? '' : '${selectedContainer[0]['CST_ID']}' : '${measList[0]['CST_ID']}' : ''
        , '@p_CST_NAME' : selectedContainer.isNotEmpty ? '${selectedContainer[0]['NAME']}' : measList.isNotEmpty ? '${measList[0]['CUST_NM']}' : '', '@p_SCALE_ID' : weighingInfoTextController.text, '@p_WEIGHT' : '${int.parse(qtyTextController.text) * int.parse(partWeiTextController.text)}',
        '@p_QTY' : qtyTextController.text, '@p_UNIT_WEIGHT' : partWeiTextController.text, '@p_WH_NO' : 'WH02',
        '@p_RACK_BARCODE' : '${selectedScLocMap['RACK_BARCODE']}', '@p_USER_ID' : Utils.getStorage.read('userId')}).then((value) =>
      {
        Get.log('스크랩 라밸 성공::::::::::: $value'),
        isEndLabel.value = true,
        scrapNo.value = value['RESULT']['DATAS'][0]['DATAS'][0]['SCRAP_NO'].toString(),
      });
      isEndLabel.value = true;
    }catch(e) {
      Utils.gErrorMessage('네트워크 오류입니다. (1)');
      isFirstDuplication.value = false;
    }
  }


  /// 재발행
  Future<void> reButton(BuildContext context) async {
    await PrintAlpha_3RB("SCRAP_LBL",{"SCRAP_NO": scrapNo.value}, context);
  }

  // 스크랩 라벨발행
  Future<void> scrapSaveButton(BuildContext context) async {
    try{
      var a = await HomeApi.to.PROC('USP_MBS1200_S01', {'@p_WORK_TYPE':'N_SCR', '@p_MATL_GB': '$matlGb', '@p_SCRAP_TYPE': selectedScrapTypeCd.value, // 1: 매입, 2: 공정, 3:외주
        '@P_SCRAP_FG': scrapFg.value, '@p_ITEM_CODE':'${selectedScrapNmMap['CODE']}', '@p_PROC_CODE': '${selectedIndustryMap['CODE']}', '@P_CST_ID': selectedContainer.isNotEmpty ? selectedContainer[0]['CST_ID'] == null ? '' :'${selectedContainer[0]['CST_ID']}' : measList.isNotEmpty ? '${measList[0]['CST_ID']}' : ''
        , '@p_CST_NAME' : selectedContainer.isNotEmpty ? '${selectedContainer[0]['NAME']}' : measList.isNotEmpty ? '${measList[0]['CUST_NM']}' : ''
        , '@P_SCALE_ID' : weighingInfoTextController.text, '@p_PLATE_FG' : selectedGoldCd.value, '@p_SLT_ID' : selectedTareMap['NAME'] == '설통번호 선택' ? '' : '${selectedTareMap['CODE']}', '@p_SLT_WEIGHT' : selectedTareMap['NAME'] == '설통번호 선택' ? '0' : '${selectedTareMap['WEIGHT']}',
        '@p_WEIGH_WEIGHT' : weighingTextController.text, '@p_WEIGHT' : selectedTareMap['NAME'] == '설통번호 선택' ? weighingTextController.text : '${double.parse(weighingTextController.text) - double.parse(selectedTareMap['WEIGHT'].toString())}', '@p_OUTS_NO' : otherScrapTextController.text, '@P_WH_NO' : 'WH04',
        '@p_RACK_BARCODE' : '${selectedScLocMap['RACK_BARCODE']}', '@p_USER_ID' : Utils.getStorage.read('userId')}).then((value) =>
      {
        Get.log('스크랩 라밸 성공::::::::::: $value'),
        isEndLabel.value = true,
        scrapNo.value = value['RESULT']['DATAS'][0]['DATAS'][0]['SCRAP_NO'].toString(),
      });
      isEndLabel.value = true;
  //    Get.log('트루 ::: ${isEndLabel.value}');
    }catch(e) {
      Utils.gErrorMessage('네트워크 오류입니다. (1)');
      isFirstDuplication.value = false;
    }

  }


  /// 프린트
  Future<void> PrintAlpha_3RB(String CODE, Map? PARAM,BuildContext context ) async{
    var bluetoothManager = FlutterSimpleBluetoothPrinter.instance;
    final bondedDevices = await bluetoothManager.getAndroidPairedDevices();

    bondedDevices.forEach((device) async {
      Get.log(device.name+"\t"+device.address+"\t"+device.isLE.toString());
      if(device.name.startsWith("Alpha-3R")){
        bool isConnected = await bluetoothManager.connect(address: device.address, isBLE: device.isLE);
        if(isConnected) {
          _showDialog(
              context,
              '라벨발행 중입니다',
              '잠시만 기다려주세요'
          );
          try {
            Map map = await HomeApi.to.REPORT_MONO_BITMAP(CODE, PARAM);
            String str = "SIZE @WIDTH@mm,@HEIGHT@mm\r\nGAP 0,0\r\nCLS\r\nBITMAP 0,0,@BITMAP_WIDTH@,@BITMAP_HEIGHT@,0,@BitmapData@\r\nPRINT 1,1\r\n";
            str = str.replaceAll("@WIDTH@", (map["WIDTH"] / 10).floor().toString())
                .replaceAll(
                "@HEIGHT@", (map["HEIGHT"] / 10).floor().toString())
                .replaceAll("@BITMAP_WIDTH@",
                ((map["BITMAP_WIDTH"] / 8).floor() + 1).toString())
                .replaceAll("@BITMAP_HEIGHT@",
                map["BITMAP_HEIGHT"].floor().toString());
            List<String> spl = str.split("@BitmapData@");
            List<List<int>> listBytes = [
              ascii.encode(spl[0]),
              map["FILE"],
              ascii.encode(spl[1]),
            ];
            Uint8List bytes = Uint8List.fromList(
                listBytes.expand((x) => x).toList());
            await bluetoothManager.writeRawData(bytes);
          }catch(ex){
            Get.log(ex.toString());
            isEndLabel.value = true;
            Utils.gErrorMessage('프린트 오류입니다.');
            Get.back();
          }
          finally {
            await bluetoothManager.disconnect();
            isEndLabel.value = true;
          }
        }else {
          Utils.gErrorMessage('프린터 연결이 끊어졌습니다.');
          isEndLabel.value = true;
        }
      }
    });
  }



  void _showDialog(BuildContext context, String title, String subTitle) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                  LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xs_8,
                  ),
                  Text(
                    title,
                    style: AppTheme.notosans600
                        .copyWith(color: Colors.black, fontSize: 17),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subTitle,
                    style: AppTheme.notosans400.copyWith(
                        color: Colors.black, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                ],
              ),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Container(
                  child: (() {
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.back();
                    });
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)))),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0))),
                              onPressed: () {
                                Get.log('취소 클릭!');
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(color: const Color(0x5c3c3c43),)
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                  top: AppTheme.spacing_s_12,
                                  bottom: AppTheme.spacing_s_12,
                                ),
                                child: Center(
                                  child: Text('닫기',
                                      style: AppTheme.titleHeadline.copyWith(
                                          color: AppTheme.black,
                                          fontSize: 17)),
                                ),
                              ),
                            ),
                          )]);
                  })(),
                ),
              ]);
        });
  }




  @override
  void onInit() async{
    selectedScLocMap.clear();
    /// 스크랩 선택으로 인한 적재위치 리스트 변경
    if(selectedGubun.value == '스크랩') {
      matlGb.value = '2';
      await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_RACK', '@p_WHERE1':'W04'}).then((value) => // 적재위치(스크랩)
      {
        selectedScLocMap['RACK_BARCODE'] = value['RESULT']['DATAS'][0]['DATAS'][0]['RACK_BARCODE'],
        selectedScLocMap['NAME'] = value['RESULT']['DATAS'][0]['DATAS'][0]['NAME'],
        scLocList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });
    }
    convert();
    popUpData();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
