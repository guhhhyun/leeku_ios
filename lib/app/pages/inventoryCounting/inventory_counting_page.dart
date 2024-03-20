import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_controller.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class InventoryCountingPage extends StatelessWidget {
  InventoryCountingPage({super.key});

  InventoryCountingController controller = Get.find();
  final focusNode2 = FocusNode();
  final focusNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.handled; // prevent passing the event into the TextField
    }
    return KeyEventResult.ignored; // pass the event to the TextField
  });

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
          child: CustomScrollView(
            slivers: [
              CommonAppbarWidget(title: '재고실사', isLogo: false, isFirstPage: true ),
              _topArea(context),
              _listArea()

            ],
          ),
        ),
        bottomNavigationBar: _bottomButton(context), //  등록
      ),
    );
  }

  Widget _topArea(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() => Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
          child: Column(
            children: [
            //  _scrapDropdown(),
              Column(
                children: [
                  const SizedBox(height: 20,),
                  _calendarItem(),
                  controller.isShowCalendar.value == true ? _calendar() : Container(),
                  const SizedBox(height: 20,),
                  _checkButton(),
                  const SizedBox(height: 20,),
                  _barcodeField(context),

                ],
              ),
              const SizedBox(height: 20,),
            ],
          )
      ), )
    );
  }

  Widget _calendarItem() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _scrapDropdown(true),
            const SizedBox(width: 16,),
            _mach()
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? _dropdownScrap('2') : controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? _dropdownScrap('3') :
            controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? _dropdownScrap('4') : _dropdownScrap('5')
          ],
        )
      ],
    );
  }


  Widget _calendar() {
    var firstDay = DateTime.utc(2022, 1, 1);
    var lastDay = DateTime.utc(2070, 12, 31);
    return Obx(
          () => Container(
        padding: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: AppTheme.light_ui_background,
            border: Border.all(color: AppTheme.light_ui_02),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  //  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  //  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 0))
            ]),
        margin: const EdgeInsets.only(
            left: AppTheme.spacing_m_16, right: AppTheme.spacing_m_16, bottom: 50),
        child: Column(
          children: [
            TableCalendar(
              currentDay: DateTime.now(),
              calendarStyle:  CalendarStyle(
                  selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  outsideDaysVisible: false,
                  defaultTextStyle: const TextStyle(fontWeight: FontWeight.w600),
                  weekendTextStyle: const TextStyle(fontWeight: FontWeight.w600)),
              locale: 'ko-KR',
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: AppTheme.titleSubhead3
                      .copyWith(color: AppTheme.light_text_primary),
                  leftChevronIcon: SvgPicture.asset(
                    'assets/app/arrow2Left.svg',
                    width: 24,
                  ),
                  leftChevronPadding: const EdgeInsets.only(left: 0),
                  formatButtonVisible: false,
                  rightChevronIcon: SvgPicture.asset(
                    'assets/app/arrow2Right.svg',
                    width: 24,
                  ) // formatButtonShowsNext: false
              ),
              firstDay: firstDay,
              lastDay: lastDay,
              /*enabledDayPredicate: (day) {
                  return controller.checkPossibleDate(day: day);
                },*/
              focusedDay: controller.selectedDay.value,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (_selectedDay, _focusedDay) {
                Get.log('onDaySelected');
                Get.log('_selectedDay = ${_selectedDay.toString()}');
                Get.log('_focusedDay = ${_focusedDay.toString()}');
                controller.selectedDay.value = _focusedDay;
                controller.dayValue.value = controller.dayValue.value = DateFormat('yyyy-MM-dd').format(controller.selectedDay.value);
                controller.bSelectedDayFlag.value = true;
                controller.isShowCalendar.value = false;
              },
            ),
            const SizedBox(height: 12,),
            const SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }

  Widget _mach() {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child:  controller.selectedCheckLocationMap['DETAIL_NM'] == '재공' ? DropdownButton(
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
            value: controller.selectedMachMap['CMH_NM'],
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.machList.map((value) {
              return DropdownMenuItem<String>(
                value: value['CMH_NM'],
                child: Text(
                  value['CMH_NM'],
                  style: AppTheme.a16500
                      .copyWith(color: value['CMH_NM'] == '설비 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.machList.map((e) {
                if(e['CMH_NM'] == value) {
                  controller.selectedMachMap['CMH_ID'] = e['CMH_ID'].toString();
                  controller.selectedMachMap['CMH_NM'] = e['CMH_NM'];
                }
                //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
              }).toList();

              Get.log('$value 선택!!!!');
              // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
            }) : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
        )
      ),
    );
  }

  Widget _checkButton() {
    return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0))),
        onPressed: () async{
          controller.controllers.clear();
          controller.productList.clear();
          var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? controller.dateValue2.value :
          controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? controller.dateValue3.value : controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.dateValue4.value : controller.dateValue5.value
            ,'@p_STK_GB':'${controller.selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.selectedMachMap['CMH_ID'] : ''}).then((value) =>
          {
            if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
              controller.productList.value = value['RESULT']['DATAS'][0]['DATAS'],
              for(var i = 0; i < controller.productList.length; i++) {
                controller.controllers.add(TextEditingController(text: '${controller.productList[i]['C04']}'))
              },
            //  controller.productList.value = controller.productList.reversed.toList()
            }
          }); /// 구분도 여쭤봐야함
          Get.log('조회 결과~~~~~ $a');
        },
        child: SizedBox(
          height: 56,
          child: Center(
              child: Text(
                '조회',
                style: AppTheme.bodyBody2.copyWith(
                  color: const Color(0xfffbfbfb),
                ),
              )),
        ));
  }

  Widget _topAreaTest(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only( right: 8),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.ae2e2e2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                    focusNode: focusNode2,
                  style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                  controller: controller.textController,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  onTap: () {
                    if(controller.focusCnt.value++ > 1) {
                      controller.focusCnt.value = 0;
                    } else {
                      Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                    }
                  },
                  onTapOutside:(event) => { controller.focusCnt.value = 0 },
                  onFieldSubmitted: (value) async {
                    await controller.saveButton();
                    controller.textController.text = '';
                    controller.controllers.clear();
                    controller.productList.clear();
                    var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? controller.dateValue2.value :
                    controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? controller.dateValue3.value : controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.dateValue4.value : controller.dateValue5.value
                      ,'@p_STK_GB':'${controller.selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.selectedMachMap['CMH_ID'] : ''}).then((value) =>
                    {
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.productList.value = value['RESULT']['DATAS'][0]['DATAS'],
                        for(var i = 0; i < controller.productList.length; i++) {
                          controller.controllers.add(TextEditingController(text: '${controller.productList[i]['C04']}'))
                        },
                        //  controller.productList.value = controller.productList.reversed.toList()
                      }
                    });
                    Future.delayed(const Duration(), (){
                      focusNode2.requestFocus();
                      //  FocusScope.of(context).requestFocus(focusNode);
                      Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () async {
                          await controller.saveButton();
                          controller.textController.text = '';
                          controller.controllers.clear();
                          controller.productList.clear();
                          FocusScope.of(context).autofocus(focusNode);
                          var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? controller.dateValue2.value :
                          controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? controller.dateValue3.value : controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.dateValue4.value : controller.dateValue5.value
                            ,'@p_STK_GB':'${controller.selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.selectedMachMap['CMH_ID'] : ''}).then((value) =>
                          {
                            if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                              controller.productList.value = value['RESULT']['DATAS'][0]['DATAS'],
                              for(var i = 0; i < controller.productList.length; i++) {
                                controller.controllers.add(TextEditingController(text: '${controller.productList[i]['C04']}'))
                              },
                              //  controller.productList.value = controller.productList.reversed.toList()
                            }
                          });
                          Future.delayed(const Duration(), (){
                            focusNode2.requestFocus();
                            //  FocusScope.of(context).requestFocus(focusNode);
                            Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                          });
                         /* SchedulerBinding.instance!.addPostFrameCallback((_) {
                            Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 4,));
                          });*/
                        },
                        child: Image.asset('assets/app/search.png', color: AppTheme.a6c6c6c, width: 32, height: 32,)
                    ),

                    contentPadding: const EdgeInsets.all(0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'BC 번호를 입력해주세요',
                    hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                    border: InputBorder.none,
                  ),
                  showCursor: true,


                ),
              ),
            ),
          ),
        ),
        /*InkWell(
            onTap: () async {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', '취소', false, ScanMode.BARCODE);
              controller.textController.text = barcodeScanRes;
              if(controller.textController.text != '-1') {
                  await controller.saveButton();
                  controller.textController.text = '';
                  FocusScope.of(context).autofocus(focusNode);
                  controller.controllers.clear();
                  controller.productList.clear();

                  var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? controller.dateValue2.value :
                  controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? controller.dateValue3.value : controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.dateValue4.value : controller.dateValue5.value
                    ,'@p_STK_GB':'${controller.selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.selectedMachMap['CMH_ID'] : ''}).then((value) =>
                  {
                    if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                      controller.productList.value = value['RESULT']['DATAS'][0]['DATAS'],
                      for(var i = 0; i < controller.productList.length; i++) {
                        controller.controllers.add(TextEditingController(text: '${controller.productList[i]['C04']}'))
                      },
                      //  controller.productList.value = controller.productList.reversed.toList()
                    }
                  });
                  Future.delayed(const Duration(), (){
                    focusNode2.requestFocus();
                    //  FocusScope.of(context).requestFocus(focusNode);
                    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                  });
              }else {
               controller.textController.text = '';
              }
            },
            child: const Icon(Icons.camera_alt_outlined, size: 30, color: AppTheme.black)
        )*/
      ],
    );
  }


  Widget _barcodeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: _topAreaTest(context)
        ),
        const SizedBox(height: 10,),
      ],
    );
  }


  Widget _scrapDropdown(bool isCheck) {
    return Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.ae2e2e2),
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.white
                ),
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(3),
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
                    value: isCheck ? controller.selectedCheckLocationMap['DETAIL_NM'] : controller.selectedSaveLocationMap['DETAIL_NM'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.locationList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['DETAIL_NM'],
                        child: Text(
                          value['DETAIL_NM'],
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.locationList.map((e) {
                        if(e['DETAIL_NM'] == value) {
                          if(isCheck) {
                            controller.selectedCheckLocationMap['DETAIL_CD'] = e['DETAIL_CD'];
                            controller.selectedCheckLocationMap['DETAIL_NM'] = e['DETAIL_NM'];
                          }else {
                            controller.selectedSaveLocationMap['DETAIL_CD'] = e['DETAIL_CD'];
                            controller.selectedSaveLocationMap['DETAIL_NM'] = e['DETAIL_NM'];
                          }
                        }

                        //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                      }).toList();
                      isCheck ? Get.log('${ controller.selectedCheckLocationMap} 선택!!!!') : Get.log('${ controller.selectedSaveLocationMap} 선택!!!!');
                    }),
              ),
            );
  }

  Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.productList.length)));
  }

  Widget _listItem({required BuildContext context, required int index}) {

    return Obx(() => Container(
              margin: const EdgeInsets.only(left: 18, bottom: 10, right: 18),
              padding: const EdgeInsets.only(top:10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.aE2E2E2),
                  color: AppTheme.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gray_c_gray_100.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: Column(
                children: [
                  controller.productList.isNotEmpty ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(controller.productList[index]['NO'].toString() ?? '',
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.black)),
                          const SizedBox(width: 12,),
                          Text(controller.productList[index]['C01'] ?? '',
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.black)),
                          const SizedBox(width: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(controller.productList[index]['C02'].toString() ?? '',
                                  style: AppTheme.a16400
                                      .copyWith(color: AppTheme.black)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 12,),
                          Row(
                            children: [
                              Text(controller.productList[index]['CD03'] == null ? '' : controller.productList[index]['CD03'].toString(),
                                  style: AppTheme.a16400
                                      .copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(width: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('중량: ',
                                  style: AppTheme.a16400
                                      .copyWith(color: AppTheme.black)),
                       /*             Text(controller.productList[index]['C04'] == null ? '' : controller.productList[index]['C04'].toString(),
                                  style: AppTheme.a16400
                                      .copyWith(color: AppTheme.black)),*/
                              controller.controllers.isNotEmpty ?
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                  style:  AppTheme.a16700.copyWith(color: AppTheme.black),
                                  // maxLines: 5,
                                  controller: controller.controllers[index],
                                  textInputAction: TextInputAction.done,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    counterText:'',
                                    hintText: '',
                                    hintStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                                    border: InputBorder.none,
                                  ),
                                  showCursor: true,

                                  // onChanged: ((value) => controller.submitSearch(value)),
                                ),
                              ) : Container(),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                      : Container(),
                ],
              ),
            ),
    );
  }

  Widget _dropdownScrap(String gb) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.ae2e2e2),
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.white
        ),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: DropdownButton(
            borderRadius: BorderRadius.circular(3),
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
            value: gb == '2' ? controller.dateValue2.value : gb == '3' ? controller.dateValue3.value :gb == '4' ? controller.dateValue4.value : controller.dateValue5.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: gb == '2' ? controller.dateList2.map((value) {
              return DropdownMenuItem<String>(
                value: value['STK_DT'],
                child: Text(
                  value['STK_DT'],
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),
                ),
              );
            }).toList() : gb == '3' ? controller.dateList3.map((value) {
              return DropdownMenuItem<String>(
                value: value['STK_DT'],
                child: Text(
                  value['STK_DT'],
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),
                ),
              );
            }).toList() :
            gb == '4' ? controller.dateList4.map((value) {
              return DropdownMenuItem<String>(
                value: value['STK_DT'],
                child: Text(
                  value['STK_DT'],
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),
                ),
              );
            }).toList() :
            controller.dateList5.map((value) {
              return DropdownMenuItem<String>(
                value: value['STK_DT'],
                child: Text(
                  value['STK_DT'],
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              gb == '2' ? controller.dateValue2.value = value! : gb == '3' ? controller.dateValue3.value = value! :gb == '4' ? controller.dateValue4.value = value! : controller.dateValue5.value = value!;

            }),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: Container(
        child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) ,
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: () async{
              await controller.updateButton();
              controller.controllers.clear();
              controller.productList.clear();
              var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.selectedCheckLocationMap['DETAIL_CD'] == '2' ? controller.dateValue2.value :
              controller.selectedCheckLocationMap['DETAIL_CD'] == '3' ? controller.dateValue3.value : controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.dateValue4.value : controller.dateValue5.value
                ,'@p_STK_GB':'${controller.selectedCheckLocationMap['DETAIL_CD']}', '@p_CMH_ID': controller.selectedCheckLocationMap['DETAIL_CD'] == '4' ? controller.selectedMachMap['CMH_ID'] : ''}).then((value) =>
              {
                if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                  controller.productList.value = value['RESULT']['DATAS'][0]['DATAS'],
                  for(var i = 0; i < controller.productList.length; i++) {
                    controller.controllers.add(TextEditingController(text: '${controller.productList[i]['C04']}'))
                  },
                  //  controller.productList.value = controller.productList.reversed.toList()
                }
              }); /// 구분도 여쭤봐야함
            },
            child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    '중량 수정',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            )),
      ),
    );
  }
}
