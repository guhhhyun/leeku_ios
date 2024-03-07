
import 'dart:async';

import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/gagongFacility/gagong_facility_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class GagongFacilityPage extends StatefulWidget {
  GagongFacilityPage({Key? key}) : super(key: key);

  @override
  State<GagongFacilityPage> createState() => _GagongFacilityPageState();
}

class _GagongFacilityPageState extends State<GagongFacilityPage> {
  GagongFacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(minutes: 3), (Timer t) => controller.checkButton());
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CommonAppbarWidget(title: '가공설 검수', isLogo: false, isFirstPage: true,),
                _bodyArea(context),
                Obx(() => controller.datasList.length == 0 ? SliverToBoxAdapter(child: Container()) :
                _list(context))
                //   _listArea()
              ],
            ),
            Obx(() => CommonLoading(bLoading: controller.isLoading.value))
          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 공정이동 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _calendarItem(context),
              const SizedBox(height: 24,),

            ],
          ),
        ),)
    );
  }

  Widget _calendarItem(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 30,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    onPressed: () async{
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        titleText: '날짜 선택',
                        itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                        context,
                        confirmText: '확인',
                        cancelText: '취소',
                        textColor: AppTheme.black,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2060),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.ko,
                        looping: true,
                      );

                      if(datePicked != null) {
                        int startIndex = datePicked.toString().indexOf(' ');
                        int lastIndex = datePicked.toString().length;
                        controller.dayStartValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                        controller.checkButton();
                      }else {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        controller.checkButton();
                      }
                      if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        controller.checkButton();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all( color: AppTheme.ae2e2e2)),
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.dayStartValue.value, style: AppTheme.a12500
                              .copyWith(color: AppTheme.a6c6c6c
                              , fontSize: 17),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                SizedBox(height: 50, width: 15, child: Center(
                  child: Text('~',style: AppTheme.a14500
                      .copyWith(color: AppTheme.black)),
                ),),
                const SizedBox(width: 12,),
                Container(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                    ),
                    onPressed: () async{
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        titleText: '날짜 선택',
                        itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                        context,
                        confirmText: '확인',
                        cancelText: '취소',
                        textColor: AppTheme.black,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2060),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.ko,
                        looping: true,
                      );
                      if(datePicked != null) {
                        int startIndex = datePicked.toString().indexOf(' ');
                        int lastIndex = datePicked.toString().length;
                        controller.dayEndValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                        controller.checkButton();
                      }else {
                        controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        controller.checkButton();
                      }
                      if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                        controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        controller.checkButton();
                      }

                      Get.log("Date Picked ${datePicked.toString()}");
                      //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.ae2e2e2)),
                      width: 150,
                      padding: const EdgeInsets.only( right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.dayEndValue.value, style: AppTheme.a14500
                              .copyWith(color: AppTheme.a6c6c6c
                              , fontSize: 17),),
                        ],
                      ),

                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                _choiceButtonItem(),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _choiceButtonItem() {
    return Row(
      children: [
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 1 ? BorderSide(color: Colors.black, width: 2): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () async{
              Get.log('검수자 미확인 클릭');
              controller.choiceButtonVal.value = 1;
              controller.callCar.value = '';
              controller.inspCh.value = 'Y';
              controller.datasList.clear();
              await controller.checkButton();

            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('검수자 미확인', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),
        const SizedBox(width: 10,),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 2 ? BorderSide(color: Colors.black, width: 2): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () async {
              Get.log('지게차 미호출 클릭');
              controller.choiceButtonVal.value = 2;
              controller.inspCh.value = '';
              controller.callCar.value = 'Y';
              controller.datasList.clear();
              await controller.checkButton();

            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('지게차 미호출', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),
        const SizedBox(width: 10,),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 3 ? const BorderSide(color: Colors.black, width: 2): const BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () async{
              Get.log('전체 클릭');
              controller.choiceButtonVal.value = 3;
              controller.callCar.value = '';
              controller.inspCh.value = '';
              controller.datasList.clear();
              await controller.checkButton();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('전체', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),

      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppTheme.a1f1f1f),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0))),
                onPressed: () async{
                  Get.log('저장 클릭!!');
                  for(var i = 0; i < controller.datasList.length; i++) {
                    if(controller.inspChList[i] == 'Y' || controller.callCarList[i] == 'Y') {
                      await controller.saveButton(i);
                    }
                  }
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', pageFlag: 6,));
                    controller.checkButton();
                  });
                },
                child: Container(
                  height: 56,
                  child: Center(
                      child: Text(
                        '저장',
                        style: AppTheme.bodyBody2.copyWith(
                          color: const Color(0xfffbfbfb),
                        ),
                      )),
                )),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context) {
    final double height = 49*(double.parse((controller.datasList.length + 1).toString()));
    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height: height,
          child: PlutoGrid(
              mode: PlutoGridMode.selectWithOneTap,
            columns: gridCols,
            rows: controller.rowDatas,
            onSelected: (PlutoGridOnSelectedEvent event) {
              Get.log('asdasd');
              setState(() {
                Get.log('${event.cell?.column.field}');
                Get.log('${event.cell?.value}');
                event.cell?.column.field == 'INSP_CHK' && event.cell?.value == '' && controller.datasList[event.cell!.row.sortIdx]['INSP_CHKDT'] == null
                    ? (event.cell?.value = 'V', controller.inspChList[event.cell!.row.sortIdx] = 'Y')
                    :  event.cell?.column.field == 'INSP_CHK' && event.cell?.value == 'V' && controller.datasList[event.cell!.row.sortIdx]['INSP_CHKDT'] == null
                    ? (event.cell?.value = '', controller.inspChList[event.cell!.row.sortIdx] = '') : null;
                event.cell?.column.field == 'CALL_CAR' && event.cell?.value == ''   && controller.datasList[event.cell!.row.sortIdx]['CARLL_CARDT'] == null
                    ? (event.cell?.value = 'V', controller.callCarList[event.cell!.row.sortIdx] = 'Y')
                    :  event.cell?.column.field == 'CALL_CAR' && event.cell?.value == 'V'  && controller.datasList[event.cell!.row.sortIdx]['CARLL_CARDT'] == null
                    ? (event.cell?.value = '', controller.callCarList[event.cell!.row.sortIdx] = '') : null;
                Get.log('${ controller.inspChList[event.cell!.row.sortIdx]}');
                Get.log('${controller.callCarList[event.cell!.row.sortIdx]}');
              });
            },
            onRowChecked: (PlutoGridOnRowCheckedEvent event) => { controller.isCheck.value = true},
           /* onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
              setState(() {
                Get.log('${event.cell.column.field}');
                Get.log('${event.cell.value}');
                event.cell.column.field == 'INSP_CHK' && event.cell.value == '' && controller.datasList[event.cell.row.sortIdx]['INSP_CHKDT'] == null
                    ? (event.cell.value = 'V', controller.inspChList[event.cell.row.sortIdx] = 'Y')
                    :  event.cell.column.field == 'INSP_CHK' && event.cell.value == 'V' && controller.datasList[event.cell.row.sortIdx]['INSP_CHKDT'] == null
                    ? (event.cell.value = '', controller.inspChList[event.cell.row.sortIdx] = '') : null;
                event.cell.column.field == 'CALL_CAR' && event.cell.value == ''   && controller.datasList[event.cell.row.sortIdx]['CARLL_CARDT'] == null
                    ? (event.cell.value = 'V', controller.callCarList[event.cell.row.sortIdx] = 'Y')
                    :  event.cell.column.field == 'CALL_CAR' && event.cell.value == 'V'  && controller.datasList[event.cell.row.sortIdx]['CARLL_CARDT'] == null
                    ? (event.cell.value = '', controller.callCarList[event.cell.row.sortIdx] = '') : null;
                Get.log('${ controller.inspChList[event.cell.row.sortIdx]}');
                Get.log('${controller.callCarList[event.cell.row.sortIdx]}');
              });
            },*/
            onLoaded: (PlutoGridOnLoadedEvent event) {
              controller.gridStateMgr = event.stateManager;
              controller.gridStateMgr?.setSelectingMode(PlutoGridSelectingMode.cell);
              //gridStateMgr.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              Get.log('sadsdasdasda');
              print(event);
            },
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                //gridBorderColor: Colors.transparent,
                  activatedColor: Colors.transparent,
                  cellColorInReadOnlyState: Colors.white,
                  columnTextStyle: AppTheme.a14500.copyWith(color: AppTheme.black)
              ),
            ),
          ),
        ),
      ],),
    );
  }

  final List<PlutoColumn> gridCols = <PlutoColumn>[
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
      title: '계량순번',
      field: 'C_WGT_NO',
      type: PlutoColumnType.text(),
      width: 90,
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
      title: '차량번호',
      field: 'C_CAR_NO',
      type: PlutoColumnType.text(),
      width: 90,
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
      title: '품목',
      field: 'C_ITEM_NAME',
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
      title: '거래처',
      field: 'C_CUST_NAME',
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
      title: '중량',
      field: 'C_ACT_QTY',
      type: PlutoColumnType.text(),
      width: 90,
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
      title: '입차 계량 시간',
      field: 'C_WGT_DATE',
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
      title: '검수자 확인',
      field: 'INSP_CHK',
      type: PlutoColumnType.text(),
      width: 90,
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
      title: '지게차 호출',
      field: 'CALL_CAR',
      type: PlutoColumnType.text(),
      width: 90,
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
      title: '검수자',
      field: 'INSP_USER',
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
      title: '검수자확인 일시',
      field: 'INSP_CHKDT',
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
      title: '지게차호출 일시',
      field: 'CARLL_CARDT',
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
  ];

  /*Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {

          return _listItem2(index: index, context: context);
        }, childCount: controller.datasList.length,)));
  }

  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border(
                        left:
                        const BorderSide(color: AppTheme.ae2e2e2),
                        top: const BorderSide(color: AppTheme.ae2e2e2),
                        right: const BorderSide(
                            color: AppTheme.ae2e2e2),
                        bottom: index == controller.datasList.length -1 ? const BorderSide(color: AppTheme.ae2e2e2) :  const BorderSide(color: Colors.transparent))),
                height: 80,
                width: 60,
                child: Center(
                  child: Text('${index + 1}',
                    style: AppTheme.a16500
                        .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                ),

              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: const BorderSide(color: AppTheme.ae2e2e2),
                          right: const BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? const BorderSide(color: AppTheme.ae2e2e2) :  const BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['C_WGT_NO'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['C_WGT_NO'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['C_CAR_NO'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['C_CAR_NO'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['C_ITEM_NAME'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['C_ITEM_NAME'].toString(),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.isDatasSelectedList[index] == false ? controller.isDatasSelectedList[index] = true
                      : controller.isDatasSelectedList[index] = false;
                  controller.isDatasSelectedList[index] == true
                      ? controller.processSelectedList.add(controller.datasList[index])
                      : controller.processSelectedList.remove(controller.datasList[index]);
                  for(var i = 0; i < controller.isDatasSelectedList.length; i++) {
                    if(controller.isDatasSelectedList2[i].toString().contains('true') || controller.isDatasSelectedList[i].toString().contains('true')) {
                      controller.registButton.value = true;
                    }else{
                      controller.registButton.value = false;
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  width: 90,
                  child: Center(
                      child: controller.isDatasSelectedList.isEmpty ?  Container() : controller.isDatasSelectedList[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
                  ),

                ),
              ),
              InkWell(
                onTap: () {
                  controller.isDatasSelectedList2[index] == false ? controller.isDatasSelectedList2[index] = true
                      : controller.isDatasSelectedList2[index] = false;
                  controller.isDatasSelectedList2[index] == true
                      ? controller.processSelectedList2.add(controller.datasList[index])
                      : controller.processSelectedList2.remove(controller.datasList[index]);
                  for(var i = 0; i < controller.isDatasSelectedList2.length; i++) {
                    if(controller.isDatasSelectedList2[i].toString().contains('true') || controller.isDatasSelectedList[i].toString().contains('true')) {
                      controller.registButton.value = true;
                    }else{
                      controller.registButton.value = false;
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  width: 90,
                  child:Center(
                      child: controller.isDatasSelectedList2.isEmpty ?  Container() : controller.isDatasSelectedList2[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
                  ),

                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Center(
                    child: Text(controller.datasList[index]['CMP_NM'].toString(),
                      style: AppTheme.a16500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2),
                        bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent),

                      )),
                  height: 80,
                  child: Center(
                      child: controller.isDatasSelectedList.isEmpty ?  Container() : controller.isDatasSelectedList[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }*/

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      left:
                      BorderSide(color: AppTheme.gray_c_gray_200),
                      top: BorderSide(color: AppTheme.gray_c_gray_200),
                      right: BorderSide(
                          color: AppTheme.gray_c_gray_200))),
              height: 80,
              width: 60,
              child: Center(
                child: Text('번호',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                    textAlign: TextAlign.left),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      top: BorderSide(color: AppTheme.gray_c_gray_200),
                      right: BorderSide(
                          color: AppTheme.gray_c_gray_200))),
              height: 80,
              width: 90,
              child: Center(
                child: Text(
                  '계량순번',
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.light_text_primary),
                ),
              ),

            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('차량번호',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('품목',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('거래처',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('중량',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('입차 계량 시간',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자 확인',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('지게차 호출',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자확인 일시',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('지게차 호출 일시',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}