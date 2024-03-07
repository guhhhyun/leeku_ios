import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilitySecond/modal_part_list_widget.dart';
import 'package:egu_industry/app/pages/facilitySecond/modal_user_list_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityController extends GetxController {

  var textController = TextEditingController();
  var textContentController = TextEditingController();
  var textItemNameController = TextEditingController();
  var textItemSpecController = TextEditingController();

  RxBool isLoading = false.obs;
  RxInt otherPartQty = 1.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedStartDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedEndDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString step1DayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 10))).obs;
  RxString step1DayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).obs;
  RxInt choiceButtonVal = 1.obs;
  RxBool isShowCalendar = false.obs;
  RxString pResultFg = 'A'.obs; /// A: 전체, N: 미조치, Y: 조치완료
  RxInt datasLength = 0.obs;
  RxList<dynamic> datasList = [].obs;
  RxList selectedDatas = [].obs;
  RxBool registButton = false.obs;
  RxList selectedContainer = [].obs;
  RxBool isAlreadySave = false.obs; // 정비내역 등록 이미 된 것 판단
  RxList<dynamic> alreadyList = [].obs; // 이미 등록된 건 조회
  RxList<dynamic> alreadyPartList = [].obs; // 이미 등록된 건 부품 조회
  RxList<String> engineerIdList = [''].obs;
  RxString selectedEnginner = '정비자를 선택해주세요'.obs;
  RxString selectedEnginnerCd = ''.obs;
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> irfgList = [''].obs;
  RxList<dynamic> irfgList2 = [].obs;
  RxList<dynamic> step1IrfgList = [].obs;
  RxMap<String, String> selectedIrFqMap2 = {'CODE':'010', 'TEXT': '돌발정비'}.obs;
  RxString selectedIrFq = '선택해주세요'.obs;
  RxString irfqCd = ''.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxString selectedCheckResultFg = '전체'.obs;
  RxList<String> resultIrFqList = ['돌발정비', '예방정비'].obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString irFgCd = '010'.obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxMap<String, String> selectedIrFqMap1 = {'CODE':'', 'TEXT': ''}.obs;
  RxString resultFgCd = ''.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '선택해주세요'.obs;
  RxString noReasonCd = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화
  RxString rpUser = ''.obs;
  RxList<String> urgencyList = ['전체','보통', '긴급'].obs;
  RxString selectedUrgency = '보통'.obs;
  RxString selectedReadUrgency = '전체'.obs;
  RxString urgencyReadCd = ''.obs;
  RxList<String> insList = ['선택해주세요', '설비점검', '안전점검'].obs;
  RxString selectedIns = '선택해주세요'.obs;
  RxString selectedReadIns = '선택해주세요'.obs;
  RxString insReadCd = ''.obs;
  RxList<dynamic> engineTeamList = [].obs;
  RxMap<String, String> selectedReadEngineTeamMap = {'CODE':'', 'TEXT': ''}.obs;
  RxString selectedReadEngineTeam = '전체'.obs;

  RxList<bool> isEngineerSelectedList = [false].obs;
  RxList<dynamic> engineerSelectedList = [].obs;
  RxList<dynamic> partAllList = [].obs; // 부품리스트
  RxList<dynamic> partList = [].obs; // 부품리스트
  RxList<bool> isPartSelectedList = [false].obs;
  RxList partSelectedList = [].obs;
  RxList<int> partQtyList = [1].obs;
  RxList<int> partSelectedQtyList = [1].obs;
  RxList<dynamic> otherPartList = [].obs;
 // RxMap<String, String> otherPartMap = {'ITEM_SPEC':'', 'ITEM_NAME': '', 'QTY': ''}.obs;
  RxList<dynamic> machList = [].obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxInt selectedMachIndex = 0.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList<String> machCdList = [''].obs;
  RxString selectedMachCd = ''.obs;
  RxList<dynamic> engineer2List = [].obs;

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜



  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'N', '@p_RP_CODE': alreadyList.isNotEmpty ? alreadyList[0]['RP_CODE'] : '', '@p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'
      , '@p_IR_FG':'${irfqCd.value}', '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}', '@p_RP_USER':selectedEnginnerCd.value,
      '@p_RP_CONTENT':textContentController.text, '@p_START_DT':'${dayStartValue.value}', '@p_END_DT':'${dayEndValue.value}',
      '@p_RESULT_FG':'${resultFgCd.value}', '@p_NO_REASON':'${noReasonCd.value}',
      '@p_RP_DEPT': null, '@p_USER':Utils.getStorage.read('userId')});
    Get.log('이거 ${a['DATAS']}');
  //  var b = a['DATAS'][0].toString().replaceFirst('{: ', '').replaceFirst('}', '');

    Get.log('저장 결과값::::: ${a['DATAS']}');

    // 부품 저장 프로시저
    if(partSelectedList.isNotEmpty) {
      for(var i = 0; i < partSelectedList.length; i++) {
        await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':alreadyList.isNotEmpty ? alreadyList[0]['RP_CODE'] : '', '@p_ITEM_CODE':'${partSelectedList[i]['ITEM_CODE']}'
          , '@p_ITEM_NAME':'${partSelectedList[i]['ITEM_NAME']}', '@p_ITEM_SPEC':'${partSelectedList[i]['ITEM_SPEC']}', '@p_USE_QTY':'${partSelectedQtyList[i]}',});
      }
    }
    if(otherPartList.isNotEmpty) {
      for(var i = 0; i < otherPartList.length; i++) {
        await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':alreadyList.isNotEmpty ? alreadyList[0]['RP_CODE'] : '', '@p_ITEM_CODE':''
          , '@p_ITEM_NAME':'${otherPartList[i]['ITEM_NAME']}', '@p_ITEM_SPEC':'${otherPartList[i]['ITEM_SPEC']}', '@p_USE_QTY':'${otherPartList[i]['QTY']}',});
      }
    }
   /* await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':'', '@p_ITEM_CODE':''
      , '@p_ITEM_NAME':'', '@p_ITEM_SPEC':'', '@p_USE_QTY':'',});*/

  }



  void clear() {
    partList.clear();
    partQtyList.clear();
    partSelectedQtyList.clear();
    isPartSelectedList.clear();
    textContentController.clear();
    dayStartValue.value = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    dayEndValue.value =  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  Future<void> partConvert(String machCode) async {
    try{

      var part = await HomeApi.to.BIZ_DATA('P_MRS001').then((value) =>
      //  var part = await HomeApi.to.PROC('USP_MBS0300_R01', {'@p_WORK_TYPE':'Q_PART',  '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}',}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          partAllList.value = value['RESULT']['DATAS'][0]['DATAS'],

          for(var i = 0; i < partAllList.length; i++) {
            if(partAllList[i]['DEPT_CODE'] == selectedContainer[0]['INS_DEPT'] && partAllList[i]['CMH_ID_SCH'].toString().contains(',${selectedContainer[0]['MACH_CODE']},')) {
              isPartSelectedList.add(false),
              partQtyList.add(1),
              partList.add(partAllList[i]),
            }

          },

        },
        Get.log('part111:  ${partList.value}'),
      Get.log('dept111:  ${selectedContainer[0]['INS_DEPT']}'),
      Get.log('mach111:  ${selectedContainer[0]['MACH_CODE']}'),

      });
    }catch(err) {
      Get.log('P_MRS001 err = ${err.toString()} ', isError: true);
    }finally {

    }


  }
  RxBool isAlreadyListData = false.obs;

  Future<void> reqAlreadyCpList() async {
    alreadyList.clear();
    alreadyPartList.clear();
    var list = await HomeApi.to.PROC22('USP_MBS0300_R01', {'@p_WORK_TYPE':'Q', '@p_RP_CODE': selectedContainer[0]['RP_CODE']}).then((value) =>
    {

        alreadyList.value = value['RESULT']['DATAS'][0]['DATAS'],
        alreadyPartList.value = value['RESULT']['DATAS'][1]['DATAS'],
        Get.log('자자자3 ${value['RESULT']['DATAS'][1]['NAMES']}'),
      if(alreadyList.isEmpty) {
        isAlreadyListData.value = false
      }else {
        isAlreadyListData.value = true
      },

      Get.log('자자자1 ${value}'),
      Get.log('자자자2 ${alreadyList.value}'),
      Get.log('자자자3 ${alreadyPartList.value}'),

    });
  }

  void insertAlreadyData() {
    var firstIndex = alreadyList[0]['START_DT']
        .toString().lastIndexOf(':');
    var lastIndex = alreadyList[0]['START_DT']
        .toString().length;
    dayStartValue.value = alreadyList[0]['START_DT'].toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, '');
    dayEndValue.value = alreadyList[0]['END_DT'].toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, '');
    alreadyList[0]['RP_CONTENT'].toString() != null || alreadyList[0]['RP_CONTENT'].toString() != '' ? textContentController.text = alreadyList[0]['RP_CONTENT'].toString() : '';
    selectedEnginnerCd.value = alreadyList[0]['RP_USER'];
    selectedEnginner.value = '';
    for(var i = 0; i < engineer2List.length; i++ ) {
      if(alreadyList[0]['RP_USER'].toString().contains(engineer2List[i]['USER_ID'].toString())) {
        selectedEnginner.value == '' ?  selectedEnginner.value = engineer2List[i]['USER_NAME'] :
        selectedEnginner.value = '${selectedEnginner.value}' + ', ${engineer2List[i]['USER_NAME']}';
        isEngineerSelectedList[i] = true;
        engineerSelectedList.add(engineer2List[i]);
      }
    }
    switch(alreadyList[0]['RESULT_FG']) {
      case "I":
        selectedResultFg.value  = '정비 진행중';
        resultFgCd.value = 'I';
        break;
      case "Y":
        selectedResultFg.value  = '정비완료';
        resultFgCd.value = 'Y';
        break;
      case "N":
        selectedResultFg.value  = '미조치';
        resultFgCd.value = 'N';
        break;
      default:
        selectedResultFg.value  = '';
        resultFgCd.value = '';
    }
    /// 확인 필요
    for(var i = 0; i < alreadyPartList.length; i++) {
      for(var k = 0; k < partList.length; k++) {
        if(alreadyPartList[i]['ITEM_CODE'].toString().contains(partList[k]['ITEM_CODE'])) {
          isPartSelectedList[k] = true;
          partSelectedList.add(partList[k]);
        }
      }
    }
  }

  Future<void> reqEngineer() async{
    var engineer = await HomeApi.to.BIZ_DATA('P_SYS029').then((value) =>
    {
      for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
        if(value['RESULT']['DATAS'][0]['DATAS'][i]['DEPT_PATH'].toString().contains(selectedContainer[0]['INS_DEPT'])) {
          engineer2List.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
          isEngineerSelectedList.add(false)
        }

      },
      // engineer2List.value = value['DATAS'],
    });
  }

  Future<void> irfgConvert() async{
    irfgList.clear();
    irfgList2.clear();
    step1IrfgList.clear();
    noReasonList.clear();
    engineer2List.clear();
    machList.clear();
    engineerSelectedList.clear();
    isEngineerSelectedList.clear();
    engineerIdList.clear();
    engineTeamList.clear();
    irfgList.add('선택해주세요');
    noReasonList.add('선택해주세요');
    selectedReadEngineTeamMap.addAll({'CODE':'', 'TEXT': '전체'});

    try{
      /// 설비
      var mach = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
      {
        // Get.log('우웅ㅇ ${value}'),
        machList.value = value['RESULT']['DATAS'][0]['DATAS']
      });
      Get.log('이거봥 ${mach}');
      var test = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
      {
        for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
          irfgList.add(value['RESULT']['DATAS'][0]['DATAS'][i]['TEXT'].toString()),
        }
      });

      var test2 = await HomeApi.to.BIZ_DATA('LCT_MR112').then((value) =>
      {
        for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++) {
          noReasonList.add(value['RESULT']['DATAS'][0]['DATAS'][i]['TEXT'].toString()),
        }
      });
      /// 점검부서
      var engineTeam = await HomeApi.to.BIZ_DATA('LCT_MR006').then((value) =>
      {
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'TEXT': '전체'}),
        engineTeamList.value = value['RESULT']['DATAS'][0]['DATAS'],
      });

      /// 정비유형
      var engineCategory = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
      {
        irfgList2.value = value['RESULT']['DATAS'][0]['DATAS'],
        value['RESULT']['DATAS'][0]['DATAS'].insert(0, {'CODE':'', 'TEXT': '전체'}),
        step1IrfgList.value = value['RESULT']['DATAS'][0]['DATAS']
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
    switch(selectedIrFq.value) {
      case "돌발 정비":
        irfqCd.value = '010';
        break;
      case "예방정비":
        irfqCd.value = '020';
        break;
      case "개조/개선":
        irfqCd.value = '030';
        break;
      case "공사성(신설)":
        irfqCd.value = '040';
        break;
      case "기타":
        irfqCd.value = '999';
      default:
        irfqCd.value = '';
    }
    switch(selectedResultFg.value) {
      case "정비 진행중":
        resultFgCd.value = 'I';
        break;
      case "정비완료":
        resultFgCd.value = 'Y';
        break;
      case "미조치":
        resultFgCd.value = 'N';
        break;
      default:
        resultFgCd.value = '';
    }
    switch(selectedNoReason.value) {
      case "부품재고 없음":
        noReasonCd.value = 'A01';
        break;
      case "내부정비불가":
        noReasonCd.value = 'A02';
        break;
      case "담당자부재":
        noReasonCd.value = 'A03';
        break;
      case "협력사 AS요청":
        noReasonCd.value = 'A04';
        break;
      case "기타":
        noReasonCd.value = 'Z99';
      default:
        noReasonCd.value = '';
    }
  }

  void step2RegistBtn() {
    if(selectedIrFq.value != '선택해주세요' && selectedResultFg.value != '전체'
        && selectedNoReason.value != '선택해주세요') {
      isStep2RegistBtn.value = true;
    }else {
      isStep2RegistBtn.value = false;
    }
  }

  void showModalUserChoice({required BuildContext context}) {
    Get.log('showModalUserChoice');

    Get.bottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
        ModalUserListWidget()
    );
  }
  void showModalPartChoice({required BuildContext context}) {
    Get.log('showModalUserChoice');
    Get.bottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
        ModalPartListWidget()
    );
  }




  @override
  void onInit() async{
    readCdConvert();
    datasList.clear();
    selectedDatas.clear();
    await HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${step1DayStartValue.value}','@p_IR_DATE_TO':'${step1DayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}'
      , '@p_INS_DEPT' : '', '@p_RESULT_FG' : pResultFg.value, '@p_IR_FG' : '010'}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
        datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
        for(var i = 0; i < datasList.length; i++){
          selectedDatas.add(false)
        },
      },
      Get.log('datasList: ${datasList}'),
    });
    irfgConvert();
    clear();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
    datasList.clear();
  }
}
