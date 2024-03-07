
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/animation.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../common/app_theme.dart';


/// 이게 작업조회
class ProcessCheckController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '작업조회(400)', '작업조회(600)', '비가동내역'].obs;
  RxString selectedGubun = '선택해주세요'.obs;
  RxString selectedGubunCd = '400'.obs;
  RxBool selectedNoWork = false.obs;
  RxBool monthCheckBox = false.obs;
  RxList<dynamic> processList = [].obs;
  RxList<dynamic> lastList = [].obs;
  RxList<dynamic> currentList = [].obs;
  RxList<dynamic> noProcessList = [].obs;
  List<PlutoRow> rowDatas = [];
  List<PlutoRow> rowDatas2 = [];
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  PlutoGridStateManager? gridStateMgr = null;
  PlutoGridStateManager? gridStateMgr2 = null;
  List<PlutoColumn>? gridCols = <PlutoColumn>[
    PlutoColumn(
      readOnly: true,
      title: '구분',
      field: 'CMH_NM',
      type: PlutoColumnType.text(),
      width: 100,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '전일',
      field: 'P_EVE',
      type: PlutoColumnType.text(),
      width: 50,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '금일',
      field: 'P_TODAY',
      type: PlutoColumnType.text(),
      width: 50,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '거래처',
      field: 'CST_NM',
      type: PlutoColumnType.text(),
      width: 150,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '슬라브',
      field: 'SLB_NO',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '제품명',
      field: 'CMP_NM',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '판롤',
      field: 'SHP_NM',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '강도',
      field: 'STT_NM',
      type: PlutoColumnType.text(),
      width: 60,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '(완)두께',
      field: 'DUKE',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '공정명',
      field: 'CPR_NM',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '(자)두께',
      field: 'THIC',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '폭',
      field: 'WIDTH',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '길이',
      field: 'LENGTH',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '중량',
      field: 'WHT',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '작업자',
      field: 'USR',
      type: PlutoColumnType.text(),
      width: 80,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '등록시간',
      field: 'DT',
      type: PlutoColumnType.text(),
      width: 110,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
  ];

  List<PlutoColumn>? gridCols2 = <PlutoColumn>[
    PlutoColumn(
      title: 'NO',
      field: 'NO',
      type: PlutoColumnType.text(),
      width: 50,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '공정명',
      field: 'CMH_NM2',
      type: PlutoColumnType.text(),
      width: 100,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '세부내역',
      field: 'NWRK_ETR',
      type: PlutoColumnType.text(),
      width: 170,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '내역',
      field: 'PROC_NAME',
      type: PlutoColumnType.text(),
      width: 130,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '시작시간',
      field: 'START_DT',
      type: PlutoColumnType.text(),
      width: 140,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '종료시간',
      field: 'END_DT',
      type: PlutoColumnType.text(),
      width: 140,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '날짜',
      field: 'NWRK_DT',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    )
  ];



  RxBool isLoading = false.obs;

  /// 400 조회
  Future<void> check400Button() async {

    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_PRR7100_R01', {'@p_WORK_TYPE':'Q1', '@p_DATE': '' }).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          processList.value = value['RESULT']['DATAS'][0]['DATAS'],
        },

      });
    /*  var lastDate = await HomeApi.to.PROC('USP_MBR1600_R02', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          lastList.value = value['DATAS'],
        },
      });
      var currentDate = await HomeApi.to.PROC('USP_MBR1600_R02', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now())}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          currentList.value = value['DATAS'],
        },
      });
      Get.log('작업조회 200:::::::::::::: ${a}');
      Get.log('작업조회 200 전일:::::::::::::: ${lastDate}');
      Get.log('작업조회 200 금일:::::::::::::: ${currentDate}');*/
      Get.log('작업조회 200:::::::::::::: ${a}');
    }catch (err) {
      Get.log('USP_MBR1600_R02 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('작업조회 데이터 오류');
    }finally {
      isLoading.value = false;
      plutoRow();

   }
  }

  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(processList.length, (index) =>
        PlutoRow(cells:
        Map.from((processList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value: key == 'STT_NM' ? value ?? '' : key == 'DUKE' ? value ?? '' :/*key == 'P_TIME' ? lastList[index]['BE_CNT']
              *//*  :  key == 'DT' ? '${value.substring(8, 10)}일 ${value.substring(11, 16)}'*//*

                :*/ value)),
        )))
    );
    gridStateMgr?.removeAllRows();
    gridStateMgr?.appendRows(rowDatas);
    gridStateMgr?.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));

  }
  Future<void> plutoRow2() async {
    rowDatas2 = List<PlutoRow>.generate(noProcessList.length, (index) =>
        PlutoRow(cells:
        Map.from((noProcessList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value:  key == 'START_DT' ? value != null && value != '' ? value.toString().replaceRange(value.toString().lastIndexOf(':'), value.toString().length, '').replaceRange(0, value.toString().lastIndexOf('T') + 1, '') : ''
                : key == 'END_DT' ?  value != null && value != '' ? value.toString().replaceRange(value.toString().lastIndexOf(':'), value.toString().length, '').replaceRange(0, value.toString().lastIndexOf('T') + 1, '') : ''
                :  key == 'NWRK_DT' ? value != null && value != '' ?  value.toString().replaceRange(value.toString().lastIndexOf('T'), value.toString().length, '')
                : value : value)),
        )))
    );
    gridStateMgr?.removeAllRows();
    gridStateMgr?.appendRows(rowDatas2);
    gridStateMgr?.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));

  }

  /// 600 조회
  Future<void> check600Button() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_PRR7100_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': '' }).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          processList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });

      Get.log('작업조회 600 :::::::::::::: ${a}');
    }catch (err) {
      Get.log('USP_PRR7100_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('작업조회 데이터 오류');
    }finally {
      isLoading.value = false;
      plutoRow();
    }

  }

  Future<void> noWorkButton() async {
    try {
      isLoading.value = true;
      // 일별 n = q2
      var a = await HomeApi.to.PROC('USP_PRR7100_R01', {'@p_WORK_TYPE':monthCheckBox.value == false ? 'Q2' : 'Q3', '@p_DATE': dayStartValue.value}).then((value) =>
      {
        if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
          noProcessList.value = value['RESULT']['DATAS'][0]['DATAS'],
        }
      });

      Get.log('비가동 내역 :::::::::::::: ${a}');
    }catch (err) {
      Get.log('USP_PRR7100_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
      plutoRow2();

    }

  }



  Future<void> convert() async {
    switch(selectedGubun.value) {
      case "작업조회(400)":
        selectedGubunCd.value = '400';
        break;
      case "작업조회(600)":
        selectedGubunCd.value = '600';
        break;
      case "비가동내역":
        selectedGubunCd.value = 'N';
        break;
      default:
        selectedGubunCd.value = '';
    }
  }

  @override
  void onInit() {
    check400Button();
 //   noWorkButton();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
    check400Button();
  }
}
