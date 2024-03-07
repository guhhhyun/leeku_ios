
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_controller.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class GongjungCheckDetailPage extends StatelessWidget {
  GongjungCheckDetailPage({Key? key}) : super(key: key);

  GongjungCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  titleSpacing: 0,
                  leading: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
                  ),
                  centerTitle: false,
                  title: Text(
                    '상세공정',
                    style: AppTheme.a18700.copyWith(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  floating: true,

                  expandedHeight: 30.0,
                  //bottom: bottom,
                ),
                _topData(),
                Obx(() => _list(context)),
                SliverToBoxAdapter(child: SizedBox(height: 100,))
                //   _listArea()
              ],
            ),
            Obx(() => CommonLoading(bLoading: controller.isLoading.value))
          ],
        ),
      ),
      //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _list(BuildContext context) {
    final double height = 59*(double.parse((controller.processDetailList.length + 1).toString()));

    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height: height,
          child: PlutoGrid(
            columns: gridCols,
            rows: controller.rowDatasDetail,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              controller.gridStateMgr2 = event.stateManager;
              controller.gridStateMgr2.setSelectingMode(PlutoGridSelectingMode.cell);
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
                  columnTextStyle: AppTheme.a14500.copyWith(color: AppTheme.black),
                  rowHeight: 55
              ),
            ),
          ),
        ),
      ],),
    );
  }

  final List<PlutoColumn> gridCols = <PlutoColumn>[
    PlutoColumn(
      title: '공정명',
      field: 'CPR_NM',
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
      title: '목표치',
      field: 'GOAL',
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
      title: '실측값',
      field: 'ACT',
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
      title: '호기',
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
      title: '작업일자',
      field: 'IST_DT',
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
      title: '작업자',
      field: 'WRK_NM',
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
      title: '공급소재',
      field: 'COIL_ID',
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
  ];

  Widget _topData() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24,  bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('번호: ', style: AppTheme.a16400,),
                Text('${controller.selectedContainer[0]['CARD_LIST_NO']}', style: AppTheme.a16700,),
                SizedBox(width: 12,),
                Text('소재: ', style: AppTheme.a16400,),
                Text('${controller.selectedContainer[0]['COIL_ID']}', style: AppTheme.a16700,),
              ],
            )
 
      ),
    );
  }



  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        padding: const EdgeInsets.only(left: 18, right: 18),
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
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('공정명',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:  MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) :
                        BorderSide(color: Colors.transparent),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('목표치',
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '실측값',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
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
                  child: Text(
                    '호기',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '작업일자',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '작업자',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '공급소재',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
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
        }, childCount: controller.processDetailList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.ae2e2e2),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['CPR_NM'].toString(),
                      style: AppTheme.a12500
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['GOAL'].toString(),
                      style: AppTheme.a12500
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['ACT'].toString(),
                      style: AppTheme.a12500
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['CMH_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['IST_DT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['WRK_NM'].toString(),
                      style: AppTheme.a12500
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
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)

                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['COIL_ID'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}