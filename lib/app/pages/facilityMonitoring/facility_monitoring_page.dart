
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_controller.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';


class FacilityMonitoringPage extends StatelessWidget {
  FacilityMonitoringPage({Key? key}) : super(key: key);

  FacilityMonitoringController controller = Get.find();

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
                  CommonAppbarWidget(title: '설비가동 모니터링', isLogo: false, isFirstPage: true,),
                  _bodyArea(context),
                  Obx(() => _list(context))
                  //   _listArea()
                ],
              ),
              Obx(() => CommonLoading(bLoading: controller.isLoading.value))
            ],
          ),
        ),
        //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppTheme.white,
        padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
        child: Column(
          children: [
            Obx(() => _choiceGb(context)),
            const SizedBox(height: 12,),
          //  _listItem(context: context, index: 1),
          ],
        ),
      ),
    );
  }

  Widget _choiceGb(BuildContext context) {
    return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedLineCd.value = '400';
                  controller.checkButton();
                },
                child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color:  controller.selectedLineCd.value == '400' ? AppTheme.black : AppTheme.ae2e2e2,
                            width: controller.selectedLineCd.value == '400' ? 2 : 1
                        )),
                    child: Center(
                      child: Text('400', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                    )
                ),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedLineCd.value = '600';
                  controller.checkButton();
                },
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color:  controller.selectedLineCd.value == '600' ? AppTheme.black : AppTheme.ae2e2e2,
                          width: controller.selectedLineCd.value == '600' ? 2 : 1
                      )),
                  child: Center(
                    child: Text('600', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                  ),
                ),
              ),
            ),
          ],
    );
  }

  Widget _list(BuildContext context) {
    final double height = 59*(double.parse((controller.monitoringList.length + 1).toString()));

    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height: height,
          child: PlutoGrid(
            columns: gridCols,
            rows: controller.rowDatas,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              controller.gridStateMgr = event.stateManager;
              controller.gridStateMgr?.setSelectingMode(PlutoGridSelectingMode.cell);
              //gridStateMgr.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event);
            },
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                defaultCellPadding: EdgeInsets.all(0),
                //gridBorderColor: Colors.transparent,
                 // rowColor: controller.rowDatas..cells.values.toString() == '가열로' ? Colors.red : Colors.white,
                  activatedColor: Colors.transparent,
                  cellColorInReadOnlyState: Colors.white,
                  columnTextStyle: AppTheme.a14500.copyWith(color: AppTheme.black),
                  rowHeight: 40,
              ),
            ),
          ),
        ),
      ],),
    );
  }

  final List<PlutoColumn> gridCols = <PlutoColumn>[
    PlutoColumn(
      title: '설비',
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
      title: '가동상태',
      field: 'STATUS_NM',
      type: PlutoColumnType.text(),
      width: 75,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
      renderer: (rendererContext) {
        Color textColor = Colors.black;

        if (rendererContext.cell.value == '가동') {
          textColor = AppTheme.a18b858;
        } else if (rendererContext.cell.value == '비가동') {
          textColor = AppTheme.affd15b;
        } else if (rendererContext.cell.value == '장애') {
          textColor = AppTheme.af34f39;
        } else {
          textColor = AppTheme.white;
        }

        return Container(
          margin: EdgeInsets.all(0),
          width: 80,
          color: textColor,
          child: Center(
            child: Text(
              rendererContext.cell.value.toString(),
              style: AppTheme.a14500.copyWith(color: Colors.black)
            ),
          ),
        );
      },
    ),
    PlutoColumn(
      title: '시간',
      field: 'LEAD_TIME',
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
      title: '상태정보',
      field: 'ALARM_VAL',
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
      title: '작업자',
      field: 'USR',
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
  ];




  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.ae2e2e2),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2),
                    )),
                height: 34,
                child: Center(
                  child: Text('설비',
                      style: AppTheme.titleSubhead1
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      top: BorderSide(color: AppTheme.ae2e2e2),
                      right: BorderSide(
                          color: AppTheme.ae2e2e2))),
              height: 34,
              width: 40,
              child: Center(
                child: Text(
                  '전일',
                  style: AppTheme.titleSubhead1
                      .copyWith(color: AppTheme.light_text_primary),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      top: BorderSide(color: AppTheme.ae2e2e2),
                      right: BorderSide(
                          color: AppTheme.ae2e2e2))),
              height: 34,
              width: 40,
              child: Center(
                child: Text(
                  '금일',
                  style: AppTheme.titleSubhead1
                      .copyWith(color: AppTheme.light_text_primary),
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                width: 60,
                child: Center(
                  child: Text(
                    '상태',
                    style: AppTheme.titleSubhead1
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                width: 60,
                child: Center(
                  child: Text('시간',
                      style: AppTheme.titleSubhead1
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('알람코드',
                      style: AppTheme.titleSubhead1
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

  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem2(index: index, context: context);
        }, childCount: controller.monitoringList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.ae2e2e2),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index ==  controller.monitoringList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent),
                      )),
                  height: 40,
                  child: Center(
                    child:   Text(controller.monitoringList[index]['CMH_NM'],
                            style: AppTheme.a12500
                                .copyWith(color: AppTheme.black)),
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: controller.monitoringList[index]['STATUS_NM'] == '가동'
                          ? AppTheme.a18b858 : controller.monitoringList[index]['STATUS_NM'] == '비가동'
                          ? AppTheme.affd15b : controller.monitoringList[index]['STATUS_NM'] == '장애'
                          ? AppTheme.af34f39 : AppTheme.a18b858,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                        bottom: index ==  controller.monitoringList.length -1 ? BorderSide(
                            color: AppTheme.ae2e2e2) : BorderSide(
                            color: Colors.transparent),)),
                  height: 40,
                  width: 60,
                  child: Center(
                      child: Text(
                          controller.monitoringList[index]['STATUS_NM'],
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
                  ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                        bottom: index ==  controller.monitoringList.length -1 ? BorderSide(
                            color: AppTheme.ae2e2e2) : BorderSide(
                            color: Colors.transparent),
                      )),
                  height: 40,
                  width: 60,
                  child: Center(
                    child: Text(controller.monitoringList[index]['LEAD_TIME'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
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
                        bottom: index ==  controller.monitoringList.length -1 ? BorderSide(
                            color: AppTheme.ae2e2e2) : BorderSide(
                            color: Colors.transparent),
                      )),
                  height: 40,
                  child: Center(
                    child: Text(controller.monitoringList[index]['ALARM_VAL'] != '' ? '${controller.monitoringList[index]['ALARM_VAL']}' : '',
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }




}