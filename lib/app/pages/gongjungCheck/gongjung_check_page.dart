
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_controller.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_detail_page.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class GongjungCheckPage extends StatelessWidget {
  GongjungCheckPage({Key? key}) : super(key: key);

  GongjungCheckController controller = Get.find();


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
                  CommonAppbarWidget(title: '공정조회', isLogo: false, isFirstPage: true,),
                  _bodyArea(context),
                  Obx(() => _list(context),),
                  SliverToBoxAdapter(child: SizedBox(height: 100,))
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
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              _choiceGb(context),
              const SizedBox(height: 12,),
              _cstField(),
              _cmpAndSttItem(),
              const SizedBox(height: 12,),
              Row(
                children: [
                  _thicField(),
                  SizedBox(width: 16,),
                  _checkButton()
                ],
              ),
              // _fromMachItem(),

              const SizedBox(height: 24,),
            ],
          ),
        ),)
    );
  }

  Widget _list(BuildContext context) {
    final double height = 59*(double.parse((controller.processList.length + 1).toString()));

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
              controller.gridStateMgr.setSelectingMode(PlutoGridSelectingMode.cell);
              //gridStateMgr.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event);
            },
            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
              Get.log('더블 클릭!!!');
              Get.log('상세공정 page로 이동');
              controller.selectedContainer.clear();
              controller.selectedContainer.add(controller.processList[event.rowIdx]);
              controller.detailCheckList();
              Get.to(GongjungCheckDetailPage());
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
      title: 'NO',
      field: 'ROW_NO',
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
      title: '공정카드번호',
      field: 'CARD_LIST_NO',
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
      title: '연번',
      field: 'tpage',
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
      title: '업체명',
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
      title: '제품명',
      field: 'CMP_NM',
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
      title: '두께',
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
      title: '폭',
      field: 'POUK',
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
      title: '폭2',
      field: 'POUK2',
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
      title: '작업날짜',
      field: 'PRC_INP_NO',
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
      title: '작업공정',
      field: 'CPR_NM',
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
      title: '작업두께',
      field: 'ACT',
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
      title: '작업호기',
      field: 'CMH_NM',
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
      field: 'WRK_NM1',
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
      title: '담당자',
      field: 'saleman',
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
      title: '메모',
      field: 'memo',
      type: PlutoColumnType.text(),
      width: 350,
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
  ];

  Widget _cmpAndSttItem() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.ae2e2e2
                )),
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.white,
                ),
                icon: SvgPicture.asset(
                  'assets/app/arrowBottom.svg',
                  color: AppTheme.light_placeholder,
                ),
                dropdownColor: AppTheme.light_ui_01,
                value: controller.selectedCmpMap['FG_NAME'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.cmpList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['FG_NAME'],
                    child: Text(
                      value['FG_NAME'],
                      style: AppTheme.a16500
                          .copyWith(color: value['FG_NAME'] == '품명 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.cmpList.map((e) {
                    if(e['FG_NAME'] == value) {
                      controller.selectedCmpMap['FG_CODE'] = e['FG_CODE'];
                      controller.selectedCmpMap['FG_NAME'] = e['FG_NAME'];
                    }
                  }).toList();
                  Get.log('$value 선택!!!!');

                }),
          ),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.ae2e2e2
                )),
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.white,
                ),
                icon: SvgPicture.asset(
                  'assets/app/arrowBottom.svg',
                  color: AppTheme.light_placeholder,
                ),
                dropdownColor: AppTheme.light_ui_01,
                value: controller.selectedSttMap['STT_NM'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.sttList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['STT_NM'],
                    child: Text(
                      value['STT_NM'],
                      style: AppTheme.a16500
                          .copyWith(color: value['STT_NM'] == '강종 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.sttList.map((e) {
                    if(e['STT_NM'] == value) {
                      controller.selectedSttMap['STT_ID'] = e['STT_ID'];
                      controller.selectedSttMap['STT_NM'] = e['STT_NM'];
                    }
                    //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                  }).toList();

                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                }),
          ),
        ),
      ],
    );
  }


  Widget _choiceGb(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 34,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.gubunCd.value = '1';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.gubunCd.value == '1' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.gubunCd.value == '1' ? 2 : 1
                    )),
                child: Center(
                  child: Text('공정조회(400)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.gubunCd.value = '3';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.gubunCd.value == '3' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.gubunCd.value == '3' ? 2 : 1
                    )),
                child: Center(
                  child: Text('공정조회(600)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
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

  Widget _cstField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.ae2e2e2),
                  borderRadius: BorderRadius.circular(10)
              ),
              width: double.infinity,
              child: TextFormField(
                style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                // maxLines: 5,
                controller: controller.textController,
                //   textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '거래처명을 입력해주세요',
                  hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                  border: InputBorder.none,
                ),
                showCursor: true,

                // onChanged: ((value) => controller.submitSearch(value)),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget _thicField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.ae2e2e2),
            borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        child: TextFormField(
          style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
          // maxLines: 5,
          controller: controller.textController2,
          //   textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.none,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            filled: true,
            hintText: '두께를 입력해주세요',
            hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
            border: InputBorder.none,
          ),
          showCursor: true,

          // onChanged: ((value) => controller.submitSearch(value)),
        ),

      ),
    );
  }

  Widget _checkButton() {
    return Expanded(
      child: Container(
        child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: () async{
              controller.checkButton();
            },
            child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                    '검색',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            )),
      ),
    );
  }



  Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.processList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {
    return Obx(() => Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: EdgeInsets.only(top: 24, bottom: 18, left: 18, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_c_gray_100.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 마노압연기 뭐시기뭐시기
          controller.processList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CST_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CMP_NM'].toString(),
                  style: AppTheme.a14500
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          SizedBox(height: 12,),

          controller.processList.isNotEmpty ?
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(controller.processList[index]['STT_NM'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['THIC'].toString()} (두께)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['THIC_ACT'].toString()} (실두께)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['WIDTH'].toString()} (폭)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['HARDNESS_ACT'].toString()} (경도)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['STOCK_QTY'].toString()} (중량)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),

            ],
          ) : Container(),
          SizedBox(height: 12,),
          controller.processList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('QC메모: ${controller.processList[index]['PP_REMARK'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.processList[index]['IN_DATE']
                            .toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595));
                  })()
              ),
            ],
          ) : Container(),
        ],
      ),
    ),
    );
  }

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            MediaQuery.of(context).size.width <= 450 ? Container() :
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
                  child: Text('No.',
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
                  child: Text('카드번호',
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
                    '연번',
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
                    '업체명',
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
                    '제품명',
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
                    '강도',
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
                    '두께',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
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
                    '폭',
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
                  child: Text('폭2',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('작업날짜',
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('작업공정',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('작업두께',
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('작업호기',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('작업자',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('담당자',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                width: 100,
                child: Center(
                  child: Text('메모',
                      style: AppTheme.a16700
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
                  child: Text('공급소재',
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

  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem2(index: index, context: context);
        }, childCount: controller.processList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: InkWell(
        onDoubleTap: () {
          Get.log('더블 클릭!!!');
          Get.log('상세공정 page로 이동');
          controller.selectedContainer.clear();
          controller.selectedContainer.add(controller.processList[index]);
          controller.detailCheckList();
          Get.to(GongjungCheckDetailPage());
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              MediaQuery.of(context).size.width <= 450 ? Container() :
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text('${index + 1}',
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  decoration:  BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                           left: MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) :
                           BorderSide(color: Colors.transparent),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['CARD_LIST_NO'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['tpage'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 6, bottom: 6),
                            child: Text(controller.processList[index]['CST_NM'].toString(),
                              style: AppTheme.a12500
                                  .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['CMP_NM'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['STT_NM'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                      child: Text(
                        controller.processList[index]['DUKE'].toStringAsFixed(2),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                         // left: MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) : BorderSide(color:),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['POUK'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['POUK2'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['PRC_INP_DT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['CPR_NM'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['ACT'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['CMH_NM'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['WRK_NM1'].toString(),
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
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['saleman'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                width: 100,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Text(controller.processList[index]['memo'].toString(),
                              style: AppTheme.a12500
                                  .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),

              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                        bottom: index == controller.processList.length -1 ? BorderSide(
                            color: AppTheme.ae2e2e2) : BorderSide(
                            color: Colors.transparent)

                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processList[index]['COIL_ID'].toString(),
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