
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/processCheck/process_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class ProcessCheckPage extends StatelessWidget {
  ProcessCheckPage({Key? key}) : super(key: key);

  ProcessCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomePage());
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                  slivers: [
                    CommonAppbarWidget(title: '작업조회', isLogo: false, isFirstPage: true,),
                    _bodyArea(context),
                    Obx(() => _monthSelect(context)),
                    Obx(() => _list(context),),
                    SliverToBoxAdapter(child: SizedBox(height: 100,))
                  ],
              ),
              Obx(() => CommonLoading(bLoading: controller.isLoading.value)),
            ],
          ),
        ),
        //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }

  Widget _monthSelect(BuildContext context) {
    return  controller.selectedNoWork.value == true ? SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.monthCheckBox.value == false ?
                      controller.monthCheckBox.value = true : controller.monthCheckBox.value = false;
                    controller.noWorkButton();
                  },
                  child: controller.monthCheckBox.value == false ? Icon(Icons.check_box_outline_blank, size: 20,) :
                  Icon(Icons.check_box, size: 20,),
                ),
                SizedBox(width: 4,),
                Text('월별', style: AppTheme.a14500.copyWith(color: AppTheme.black),),
                SizedBox(width: 12,),
                Container(
                  child: InkWell(
                    onTap: () async{
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        titleText: '날짜 선택',
                        itemTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
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
                        controller.noWorkButton();
                        /*if(controller.choiceButtonVal.value != 0) {
                          controller.datasList.clear();
                          HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                            , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.irFgCd.value}).then((value) =>
                          {
                            Get.log('value[DATAS]: ${value['DATAS']}'),
                            if(value['DATAS'] != null) {
                              controller.datasLength.value = value['DATAS'].length,
                              for(var i = 0; i < controller.datasLength.value; i++){
                                controller.datasList.add(value['DATAS'][i]),
                              },
                            },
                            Get.log('datasList: ${controller.datasList}'),
                          });
                        }*/



                      }else {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }
                      if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 150,
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

              ],
            ),
          ),
          SizedBox(height: 24,),
        ],
      ),
    ) : SliverToBoxAdapter(child:  SizedBox(height: 24,),);
  }

  Widget _list(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height:  49*(double.parse((controller.processList.length).toString())),
          child: PlutoGrid(
            columns: controller.gridCols!,
            rows: controller.rowDatas,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              controller.gridStateMgr = event.stateManager;
              controller.gridStateMgr!.setSelectingMode(PlutoGridSelectingMode.cell);
              //gridStateMgr.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
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


  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() => _choiceGb(context)),
                  const SizedBox(width: 12,),
                ],
              ),
             // const SizedBox(height: 24,),
            ],
          ),
        ),
    );
  }

  Widget _choiceGb(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                controller.selectedNoWork.value = false;
                controller.selectedGubunCd.value = '400';
               controller.gridStateMgr?.removeColumns(controller.gridCols2!);
               controller.gridStateMgr?.removeColumns(controller.gridCols!);
                controller.gridStateMgr?.insertColumns(0, <PlutoColumn>[
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
                ]);
                await controller.check400Button();
                controller.gridStateMgr?.removeAllRows();
                controller.gridStateMgr?.appendRows(controller.rowDatas);

              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == '400' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == '400' ? 2 : 1
                    )),
                child: Center(
                  child: Text('400', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () async{
                controller.selectedNoWork.value = false;
                controller.selectedGubunCd.value = '600';
                controller.gridStateMgr?.removeColumns(controller.gridCols2!);
                controller.gridStateMgr?.removeColumns(controller.gridCols!);
                controller.gridStateMgr?.insertColumns(0, <PlutoColumn>[
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
                ]);
                await controller.check600Button();
                controller.gridStateMgr!.removeAllRows();
                controller.gridStateMgr?.appendRows(controller.rowDatas);


              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == '600' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == '600' ? 2 : 1
                    )),
                child: Center(
                  child: Text('600', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () async{
             //   controller.gridStateMgr?.removeColumns(controller.gridCols!);
                controller.selectedNoWork.value = true;
                controller.selectedGubunCd.value = '';
                controller.gridStateMgr?.removeColumns(controller.gridCols!);
                controller.gridStateMgr?.insertColumns(0, controller.gridCols2!);
                await controller.noWorkButton();
                controller.gridStateMgr?.removeAllRows();
                controller.gridStateMgr?.appendRows(controller.rowDatas2);

              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedNoWork.value ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedNoWork.value ? 2 : 1
                    )),
                child: Center(
                  child: Text('비가동', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            /*const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.selectedGubunCd.value = 'N';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == 'N' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == 'N' ? 2 : 1
                    )),
                child: Center(
                  child: Text('비가동내역', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }


}