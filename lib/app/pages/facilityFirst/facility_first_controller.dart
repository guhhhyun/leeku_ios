import 'dart:typed_data';

import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_modify_page.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityFirstController extends GetxController {

  var textTitleController = TextEditingController();
  var textContentController = TextEditingController();
  var textFacilityController = TextEditingController();
  /// 수정 페이지--------------------------------------------------
  var modifyTextFacilityController = TextEditingController();
  var modifyTextTitleController = TextEditingController();
  var modifyTextContentController = TextEditingController();

  RxBool isLoading = false.obs;

  RxString modifyIrCode = ''.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  RxList<String> insList = ['설비점검', '안전점검'].obs;
  RxString selectedIns = '설비점검'.obs;
  RxString selectedReadIns = '선택해주세요'.obs;
  RxString insCd = ''.obs;
  RxString insReadCd = ''.obs;
  RxList<String> urgencyList = ['전체','보통', '긴급'].obs;
  RxList<String> step2UrgencyList = ['보통', '긴급'].obs;
  RxString selectedUrgency = '보통'.obs;
  RxString selectedReadUrgency = '전체'.obs;
  RxString urgencyCd = ''.obs;
  RxString urgencyReadCd = ''.obs;
  RxList<dynamic> machList = [].obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxInt selectedMachIndex = 0.obs;
  RxList<String> machCdList = [''].obs;
  RxString selectedMachCd = ''.obs;
  RxList<dynamic> step1IrfgList = [].obs;
  RxList<dynamic> irfgList = [].obs;
  RxMap<String, String> selectedIrFqMap = {'CODE':'010', 'TEXT': '돌발정비'}.obs;
  RxMap<String, String> checkSelectedIrFqMap = {'CODE':'010', 'TEXT': '돌발정비'}.obs;
  RxString selectedIrFq = '선택해주세요'.obs;
  RxString selectedReadIrFq = '선택해주세요'.obs;
  RxList<dynamic> engineTeamList = [].obs;
  RxList<dynamic> step2EngineTeamList = [].obs;
  RxMap<String, String> selectedEngineTeamMap = {'CODE':'', 'TEXT': '전기팀'}.obs;

  RxMap<String, String> selectedReadEngineTeamMap = {'CODE':'', 'TEXT': ''}.obs;
  RxString engineTeamCd = ''.obs;
  RxString engineTeamReadCd = ''.obs;
  RxString errorTime = ''.obs;
  RxString errorTime2 = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화
  RxString engineTeamRead = ''.obs;

  RxString irFileCode = ''.obs; // 파일 저장을 위한 ir코드
  RxString pResultFg = 'A'.obs; /// A: 전체, N: 미조치, Y: 조치완료
  RxString filePath = ''.obs;
  RxString filePath2 = ''.obs;
  RxString filePath3 = ''.obs;
  RxString filePath4 = ''.obs;
  RxList<String> filePathList = [''].obs;



  RxString dayValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 10))).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxInt choiceButtonVal = 1.obs;
  RxBool isShowCalendar = false.obs;
  RxInt datasLength = 0.obs;
  RxInt modifyDatasLength = 0.obs;
  RxList datasList = [].obs;
  RxList<dynamic> modifyDatasList = [].obs;
  RxList isSelect = [].obs;
  RxBool registButton = false.obs;
  RxList selectedContainer = [].obs;
  RxList<String> engineerList = [''].obs;
  RxList<String> engineerIdList = [''].obs;
  RxString selectedEnginner = '정비자를 선택해주세요'.obs;
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '전체'.obs;
  RxString noReasonCd = ''.obs;


  /// 수정 페이지 ----------------------------
  RxList<String> modifyInsList = ['설비점검', '안전점검'].obs;
  RxString modifySelectedIns = '설비점검'.obs;
  RxString modifySelectedReadIns = '선택해주세요'.obs;
  RxString modifyInsCd = ''.obs;
  RxString modifyInsReadCd = ''.obs;
  RxList<String> modifyUrgencyList = ['보통', '긴급'].obs;
  RxString modifySelectedReadUrgency = '보통'.obs;
  RxString modifyUrgencyCd = ''.obs;
  RxList<dynamic> modifyMachList = [].obs;
  RxString modifySelectedMach = '선택해주세요'.obs;
  RxMap<String, String> modifySelectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList<dynamic> modifyIrfgList = [].obs;
  RxMap<String, String> modifySelectedIrFqMap = {'CODE':'', 'TEXT': ''}.obs;
  RxString modifyErrorTime = ''.obs;
  RxString modifyErrorTime2 = ''.obs;
  RxList<String> modifyEngineerList = [''].obs;
  RxList<String> modifyEngineerIdList = [''].obs;
  RxString modifySelectedEnginner = '정비자를 선택해주세요'.obs;
  RxInt modifySelectedEnginnerIndex = 0.obs;
  RxList<String> modifyResultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString modifySelectedResultFg = '전체'.obs;
  RxString selectedCheckResultFg = '전체'.obs;
  RxList<String> resultIrFqList = ['돌발정비', '예방정비'].obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString irFgCd = '010'.obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxBool isModifyErrorDateChoice = false.obs;
  RxList<dynamic> modifyEngineTeamList = [].obs;
  RxMap<String, String> modifyEngineTeamCdMap = {'CODE':'', 'TEXT': ''}.obs;
  RxList<dynamic> imageList = [].obs;

  /// --------------------------------------------------------------------------

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜
  RxString path = ''.obs;

  RxBool isErrorDateChoice = false.obs;
  RxList<dynamic> fileList = [].obs; // 조회된 사진리스트(수정페이지)
  RxList<dynamic> fileDelList = [].obs;
  RxList<dynamic> fileSeqList = [].obs; // 조회된 사진 Seq리스트(수정페이지)
  XFile? resultFile1 = null;
  XFile? resultFile2 = null;
  XFile? resultFile3 = null;
  XFile? resultFile4 = null;


  RxList<dynamic> newImageList = [].obs;


  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0200_S01', {'@p_WORK_TYPE':'N', '@p_IR_CODE':''
      , '@p_INS_FG':insCd.value, '@p_MACH_CODE':selectedMachMap['MACH_CODE'], '@p_MACH_ETC':selectedMachMap['MACH_NAME'] == '전체' ? textFacilityController.text : '',
      '@p_IR_TITLE':textTitleController.text, '@p_IR_CONTENT':'${textContentController.text}', '@p_IR_USER':Utils.getStorage.read('userId'),
      '@p_FAILURE_DT':errorTime.value, '@p_IR_FG':selectedIrFqMap['CODE'], '@p_URGENCY_FG':urgencyCd.value,
      '@p_INS_DEPT':selectedEngineTeamMap['CODE'], '@p_USER':Utils.getStorage.read('userId')});
    Get.log('신규등록 :::::::: ${a['DATAS'][0]['IR_CODE']}');
     irFileCode.value = a['DATAS'][0]['IR_CODE'];

    /// 사진파일 프로시저 추가해야함

  }
  Future<void> modifySaveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0200_S01', {'@p_WORK_TYPE':'U', '@p_IR_CODE': modifyIrCode.value
      , '@p_INS_FG':modifyInsCd.value, '@p_MACH_CODE':modifySelectedMachMap['MACH_CODE'], '@p_MACH_ETC': modifySelectedMachMap['MACH_NAME'] == '전체' ? modifyTextFacilityController.text : '',
      '@p_IR_TITLE':modifyTextTitleController.text, '@p_IR_CONTENT':'${modifyTextContentController.text}', '@p_IR_USER':Utils.getStorage.read('userId'),
      '@p_FAILURE_DT': modifyErrorTime.value, '@p_IR_FG':modifySelectedIrFqMap['CODE'], '@p_URGENCY_FG': modifyUrgencyCd.value,
      '@p_INS_DEPT': modifyEngineTeamCdMap['CODE'], '@p_USER':Utils.getStorage.read('userId'),});

    /// 사진파일 프로시저 추가해야함

  }

  Future<void> reqFileData() async {
    fileList.clear();
    var a = await HomeApi.to.PROC('USP_MBS0200_R01', {'@p_WORK_TYPE':'FILE_Q', '@p_IR_CODE': selectedContainer[0]['IR_CODE']}).then((value) =>
    {
      fileList.value = value['RESULT']['DATAS'][0]['DATAS'],
      for(var i = 0 ; i < fileList.length; i++) {
        fileSeqList.add(fileList[i]['SEQ']),
      },
    });
    fileList.length == 1 ? resultFile1 = new XFile('') : fileList.length == 2 ? {resultFile1 = new XFile(''), resultFile2 = new XFile('')}
        : fileList.length == 3 ? {resultFile1 = new XFile(''), resultFile2 = new XFile(''), resultFile3 = new XFile('')}
        : fileList.length == 4 ? {resultFile1 = new XFile(''), resultFile2 = new XFile(''), resultFile3 = new XFile(''), resultFile4 = new XFile('')} : null;
    Get.log('fileList.value::: ${fileList.value}');
  }

  Future<void> reqFileDownloadData() async {
    for(var i = 0 ; i < fileList.length; i++) {
      Uint8List data = await HomeApi.to.FILE_DOWNLOAD(fileList[i]['PATH']);
      var image = MemoryImage(data);
      imageList.add(image);
    }
    Get.log('imageList.value::: ${imageList}');
  }

  // 수정페이지에서 기존에 등록된 이미지 말고 새로 가져올 시
  Future<void> reqNewFileDownloadData(String path) async {

    Uint8List data = await HomeApi.to.FILE_DOWNLOAD(path);
    var image = MemoryImage(data);
    imageList.add(image);

    Get.log('imageList.value::: ${imageList}');
  }


  Future<void> deleteFileData(int seq) async {
    var a = await HomeApi.to.PROC('USP_MBS0200_S01', {'@p_WORK_TYPE':'FILE_D', '@p_IR_CODE': selectedContainer[0]['IR_CODE'], '@p_USER' : Utils.getStorage.read('userId'),
      '@p_SEQ' : seq});
  }

  void modifyIrfqCdCv() {
    modifyIrfgList.map((e) {
      if(e['CODE'] == modifySelectedIrFqMap['CODE']) {
        modifySelectedIrFqMap['CODE'] = e['CODE'];
        modifySelectedIrFqMap['TEXT'] = e['TEXT'];
      }
        Get.log('modifySelectedIrFqMap::: $modifySelectedIrFqMap 선택!!!!');
    }).toList();

    modifyEngineTeamList.map((e) {
      if(e['CODE'] == modifyEngineTeamCdMap['CODE']) {
        modifyEngineTeamCdMap['CODE'] = e['CODE'];
        modifyEngineTeamCdMap['TEXT'] = e['TEXT'];
      }
      Get.log('modifyEngineTeamCdMap::: $modifyEngineTeamCdMap 선택!!!!');
    }).toList();
    if(modifyEngineTeamCdMap['TEXT'] == null || modifyEngineTeamCdMap['TEXT'] == '') {
      modifyEngineTeamCdMap['TEXT'] = '기타';
      modifyEngineTeamCdMap['CODE'] = '9999';
    }

  }

  Future<void> convert() async{
    machList.clear();
    modifyMachList.clear();
    irfgList.clear();
    step1IrfgList.clear();
    modifyIrfgList.clear();
    engineTeamList.clear();
    step2EngineTeamList.clear();
    modifyEngineTeamList.clear();
    machCdList.clear();
    selectedMachMap.clear();
    modifySelectedMachMap.clear();
    modifyEngineTeamCdMap.clear();
    modifyIrfgList.add('선택해주세요');
    selectedMachMap.addAll({'MACH_CODE':'00', 'MACH_NAME': '전체'});
    modifySelectedMachMap.addAll({'MACH_CODE':'00', 'MACH_NAME': '전체'});
    selectedReadEngineTeamMap.addAll({'CODE':'', 'TEXT': '전체'});
    modifySelectedIrFqMap.clear();

    try{
      /// 설비
      var muc = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
      {
        // Get.log('우웅ㅇ ${value}'),
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'MACH_CODE':'00', 'MACH_NAME': '전체'}),
        machList.value = value['RESULT']['DATAS'][0]['DATAS'],
        modifyMachList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('설비 :  : : $muc');

      /// 점검부서
      var engineTeam = await HomeApi.to.BIZ_DATA('LCT_MR006').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'TEXT': '전체'}),
        engineTeamList.value = value['RESULT']['DATAS'][0]['DATAS'],

      });
      var engineTeam2 = await HomeApi.to.BIZ_DATA('LCT_MR006').then((value) =>
      {
        step2EngineTeamList.value = value['RESULT']['DATAS'][0]['DATAS'],
        modifyEngineTeamList.value = value['RESULT']['DATAS'][0]['DATAS'],

      });

      /// 정비유형
      var engineCategory = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'TEXT': '전체'}),
        step1IrfgList.value = value['RESULT']['DATAS'][0]['DATAS'],
        Get.log('aaaaa ${step1IrfgList.value}')
      });
      var engineCategory2 = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
      {
        irfgList.value = value['RESULT']['DATAS'][0]['DATAS'],
        modifyIrfgList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }
  void readCdConvert() {
    switch(selectedReadUrgency.value) {
      case "보통":
        urgencyReadCd.value = 'N';
        break;
      case "긴급":
        urgencyReadCd.value = 'U';
        break;
      default:
        urgencyReadCd.value = '';
    }


  }


  void cdConvert() {
    switch(selectedIns.value) {
      case "설비점검":
        insCd.value = 'M';
        break;
      case "안전점검":
        insCd.value = 'S';
        break;
      default:
        insCd.value = '';
    }
    switch(modifySelectedIns.value) {
      case "설비점검":
        modifyInsCd.value = 'M';
        break;
      case "안전점검":
        modifyInsCd.value = 'S';
        break;
      default:
        modifyInsCd.value = '';
    }
    switch(selectedUrgency.value) {
      case "보통":
        urgencyCd.value = 'N';
        break;
      case "긴급":
        urgencyCd.value = 'U';
        break;
      default:
        urgencyCd.value = '';
    }
    switch(modifySelectedReadUrgency.value) {
      case "보통":
        modifyUrgencyCd.value = 'N';
        break;
      case "긴급":
        modifyUrgencyCd.value = 'U';
        break;
      default:
        modifyUrgencyCd.value = 'N';
    }
  }






  void step2RegistBtn() {
    if(selectedIrFq.value != '전체' && selectedResultFg.value != '전체'
        && selectedNoReason.value != '전체') {
      isStep2RegistBtn.value = true;
    }else {
      isStep2RegistBtn.value = false;
    }
  }

  void check() {
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${dayStartValue.value}','@p_IR_DATE_TO':'${dayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}'
      , '@p_INS_DEPT' : '${engineTeamReadCd.value}', '@p_RESULT_FG' : pResultFg.value, '@p_IR_FG' : checkSelectedIrFqMap['CODE']}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
        for(var i = 0; i < datasLength.value; i++){
          datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
        },
      },
      Get.log('datasList: ${datasList}'),
    });
  }

  /// 선택된 설비/안전 조회 정보
  void modifyCheck() {
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q1', 'p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
      modifyDatasList.value = value['RESULT']['DATAS'][0]['DATAS'],
      if(modifyDatasList.isNotEmpty) {
        modifySelectedIrFqMap['CODE'] = modifyDatasList[0]['IR_FG'],
        modifyEngineTeamCdMap['CODE'] = modifyDatasList[0]['INS_DEPT'],
        modifyIrfqCdCv(),
        modifyDatasList[0]['MACH_ETC'] != null ?
        modifyTextFacilityController.text = modifyDatasList[0]['MACH_ETC'] :  modifyTextFacilityController.text = '',
        modifyInsCd.value = modifyDatasList[0]['INS_FG'],
        modifyInsCd.value == 'M' ? modifySelectedIns.value = '설비점검' : modifySelectedIns.value = '안전점검',
        modifyIrCode.value = modifyDatasList[0]['IR_CODE'],
        modifyTextContentController.text = modifyDatasList[0]['IR_CONTENT'],
      },

      Get.log('modifyDatasList: $modifyDatasList'),
    });
  }

  @override
  void onInit() {
    readCdConvert();
    datasList.clear();
    convert();
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${dayStartValue.value}','@p_IR_DATE_TO':'${dayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}', '@p_INS_DEPT' : ''
      , '@p_RESULT_FG' : pResultFg.value, '@p_IR_FG' : '010'}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
        for(var i = 0; i < datasLength.value; i++){
          datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
        },
      },
      Get.log('datasList: ${datasList}'),
    });
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
