import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_modify_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step2_page.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityFirstStep1Page extends StatelessWidget {
  FacilityFirstStep1Page({Key? key}) : super(key: key);

  FacilityFirstController controller = Get.find();


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
                  CommonAppbarWidget(title: '설비/안전 의뢰 조회', isLogo: false, isFirstPage: true ),
                  _bodyArea(context),
                  _listArea()
                ],
              ),
              Obx(() => CommonLoading(bLoading: controller.isLoading.value))
            ],
          ),
        ),
        bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
          color: AppTheme.white,
          padding: EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              Obx(() => _calendar2(context),),
              SizedBox(height: 12,),
              _urgenTeamItem(),
              SizedBox(height: 12,),
              Row(
                children: [
                  _dropDownItem(),
                  SizedBox(width: 16,),
                  _irFqDropDownItem()
                ],
              ),
              SizedBox(height: 36,),
            ],
          ),
        ),
    );
  }

  Widget _calendar2(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }



                }else {
                  controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                  controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
              },
              child: Container(
                height: 50,
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
        ),
        const SizedBox(width: 12,),
        SizedBox(height: 50, width: 15, child: Center(
          child: Text('~',style: AppTheme.a14500
              .copyWith(color: AppTheme.black)),
        ),),
        const SizedBox(width: 12,),
        Expanded(
          child: Container(
            child: InkWell(
              onTap: () async{
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
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }


                }else {
                  controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                  controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
        ),
      ],
    );
  }

  Widget _calendarItem() {

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            AppTheme.light_ui_background
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide(color: AppTheme.ae2e2e2),
                borderRadius: BorderRadius.circular(10)
            )),
      ),
      onPressed: () {
        Get.log('날짜 클릭');
        controller.isShowCalendar.value = true;

      },
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        /*  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppTheme.gray_c_gray_200)
        ),*/
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: AppTheme.a959595, size: 20,),
            SizedBox(width: 8,),
            Text('${controller.dayValue.value}', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),)
          ],
        ),
      ),
    );
  }

  Widget _urgenTeamItem() {
    return Obx(()=> Row(
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
            child: DropdownButton<String>(
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
                value: controller.selectedReadUrgency.value,
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.urgencyList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReadUrgency.value = value!;
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }
                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
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
                value: controller.selectedReadEngineTeamMap['TEXT'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.engineTeamList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['TEXT'],
                    child: Text(
                      value['TEXT'],
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.engineTeamList.map((e) {
                    if(e['TEXT'] == value) {
                      controller.selectedReadEngineTeamMap['CODE'] = e['CODE'];
                      controller.selectedReadEngineTeamMap['TEXT'] = e['TEXT'];
                    }

                    //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                  }).toList();
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }

                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                }),
          ),
        ),
      ],
    ));
  }

  Widget _dropDownItem() {
    return Obx(() => Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(
              height: 1,
              color: Colors.white,
            ),
            icon: SvgPicture.asset(
              'assets/app/arrowBottom.svg',
              color: AppTheme.light_ui_08,
            ),
            dropdownColor: AppTheme.light_ui_01,
            value: controller.selectedCheckResultFg.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.resultFgList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.a14500
                      .copyWith(color:  AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.selectedCheckResultFg.value = value!;
              if(value == '전체') {
                controller.choiceButtonVal.value = 1;
                controller.pResultFg.value = 'A';
                for(var i = 0; i < controller.isSelect.length; i++) {
                  controller.isSelect[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  controller.datasList.clear(),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });

              }else if(value == '미조치') {
                Get.log('미조치 클릭');
                controller.choiceButtonVal.value = 2;
                controller.pResultFg.value = 'N';
                for(var i = 0; i < controller.isSelect.length; i++) {
                  controller.isSelect[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });

              }else if(value == '정비완료') {
                Get.log('정비완료 클릭');
                controller.choiceButtonVal.value = 3;
                controller.pResultFg.value = 'Y';
                for(var i = 0; i < controller.isSelect.length; i++) {
                  controller.isSelect[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });

              }else if(value == '정비 진행중') {
                Get.log('조치 진행중 클릭');
                controller.choiceButtonVal.value = 4;
                controller.pResultFg.value = 'I';
                for(var i = 0; i < controller.isSelect.length; i++) {
                  controller.isSelect[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':controller.checkSelectedIrFqMap['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }
            }),

      ),
    ));
  }

  Widget _irFqDropDownItem() {
    return Obx(()=> Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: DropdownButton(
            dropdownColor: AppTheme.light_ui_01,
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
            value: controller.checkSelectedIrFqMap['TEXT'],
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.step1IrfgList.map((value) {
              return DropdownMenuItem<String>(
                value: value['TEXT'],
                child: Text(
                  value['TEXT'],
                  style: AppTheme.a16400
                      .copyWith(color:  AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.step1IrfgList.map((e) {
                if(e['TEXT'] == value) {
                  controller.checkSelectedIrFqMap['TEXT'] = e['TEXT'];
                  controller.checkSelectedIrFqMap['CODE'] = e['CODE'];
                }

                //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
              }).toList();
            //  controller.selectedCheckIrFg.value = value!;
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.checkSelectedIrFqMap['CODE']}).then((value) =>
              {
                Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                  controller.datasLength.value = value['RESULT']['DATAS'][0]['DATAS'].length,
                  for(var i = 0; i < controller.datasLength.value; i++){
                    controller.datasList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
              Get.log('$value 선택!!!!');
              // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
            }),

        /*DropdownButton<String>(
            isExpanded: true,
            underline: Container(
              height: 1,
              color: Colors.white,
            ),
            icon: SvgPicture.asset(
              'assets/app/arrowBottom.svg',
              color: AppTheme.light_ui_08,
            ),
            dropdownColor: AppTheme.light_ui_01,
            value: controller.selectedCheckIrFg.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.resultIrFqList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.a14500
                      .copyWith(color:  AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.selectedCheckIrFg.value = value!;
              if(value == '돌발정비') {
                controller.irFgCd.value = '010';
              }else if(value == '예방정비') {
                controller.irFgCd.value = '020';
              }else {
                controller.irFgCd.value = '';
              }
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.irFgCd.value}).then((value) =>
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
            }),*/

      ),
    ));
  }

  Widget _listArea() {
    controller.isSelect.clear();
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          controller.isSelect.add(false);
          return _listItem(index: index, context: context);
        }, childCount: controller.datasList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {
    return  TextButton(
      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5)))),
          /*backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.light_primary,
              ),*/
          padding:
          MaterialStateProperty.all(const EdgeInsets.all(0))),
      onPressed: () async{
        if(controller.isSelect[index] == true) {
          controller.isSelect[index] = false;
          controller.registButton.value = false;
          controller.selectedContainer.clear();
        }else {
          try{
            controller.isLoading.value = true;
            for(var i = 0; i < controller.isSelect.length; i++) {
              controller.isSelect[i] = false;
            }
            controller.selectedContainer.clear();
            controller.isSelect[index] = true;
            if(controller.isSelect[index] == true) {
              controller.registButton.value = true;
              controller.selectedContainer.add(controller.datasList[index]);
            }
            controller.modifyCheck();
            modifyEngineTeam();
            controller.modifyErrorTime.value = controller.selectedContainer[0]['IR_DATE'];
            var indexLast = controller.modifyErrorTime.value.lastIndexOf(':');
            controller.modifyErrorTime.value = controller.modifyErrorTime.value.replaceFirst('T', ' ').replaceRange(indexLast, controller.modifyErrorTime.value.length, '');
            controller.selectedContainer[0]['INS_FG'] == 'M' ? controller.modifySelectedIns.value = '설비점검' : controller.modifySelectedIns.value = '안전점검';
            controller.selectedContainer[0]['URGENCY_FG'] == 'N' ? controller.modifySelectedReadUrgency.value = '보통' : controller.modifySelectedReadUrgency.value = '긴급';
            controller.modifySelectedMachMap['MACH_CODE'] = controller.selectedContainer[0]['MACH_CODE'];
            controller.selectedContainer[0]['MACH_CODE'] == '' ? controller.modifySelectedMachMap['MACH_NAME'] = '전체' : controller.modifySelectedMachMap['MACH_NAME'] = modifyMach();
            controller.modifyTextTitleController.text = controller.selectedContainer[0]['IR_TITLE'];
            await controller.reqFileData();
            await controller.reqFileDownloadData();
          }catch(err) {
            Get.log(err.toString());
          }finally {
            controller.isLoading.value = false;
          }



          Get.to(const FacilityFirstModifyPage());
        }
      },
      child: Obx(() => Container(
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
        padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: controller.isSelect[index] ? Border.all(color: AppTheme.black, width: 3) : Border.all(color: AppTheme.ae2e2e2),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.datasList.isNotEmpty ?
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.datasList[index]['URGENCY_FG'].toString() != 'N' ? AppTheme.afef1ef :
                          AppTheme.aecf9f2
                      ),
                      child: Text(controller.datasList[index]['URGENCY_FG'].toString() == 'N' ? '보통' : '긴급', /// 긴급 or 보통 으로
                          style: AppTheme.a12500
                              .copyWith(color: controller.datasList[index]['URGENCY_FG'].toString() != 'N' ? AppTheme.af34f39 : AppTheme.a18b858)),
                    ),
                    const SizedBox(width: 4,),
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  AppTheme.af4f4f4
                      ),

                      child: Text(controller.datasList[index]['INS_FG'].toString() == 'M' ? '설비점검' : '안전점검',
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.a969696)),
                    ),
                    const SizedBox(width: 4,),
                    controller.datasList[index]['RESULT_FG'].toString() == '' ? Container() :
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? Color(0xffF0FFFF) : Color(0xffFFFFE0)
                      ),

                      child: Text(controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? '정비완료'
                          : controller.datasList[index]['RESULT_FG'].toString() == 'I' ? '정비 진행중' :
                      controller.datasList[index]['RESULT_FG'].toString() == 'N' ? '미조치' : '',
                          style: AppTheme.a12500
                              .copyWith(color: controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? Color(0xff1E90FF) : Colors.orangeAccent)),
                    ),

                    controller.datasList[index]['IR_FG'].toString() == '' ? Container() :
                    Container(
                      margin: controller.datasList[index]['RESULT_FG'].toString() != '' ?const EdgeInsets.only(left: 4) : null,
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  AppTheme.af4f4f4
                      ),

                      child: Text( controller.datasList[index]['IR_FG'].toString() == '010' ? '돌발정비'
                          : controller.datasList[index]['IR_FG'].toString() == '020' ? '예방정비' : controller.datasList[index]['IR_FG'].toString() == '030' ? '개조/개선' :
                      controller.datasList[index]['IR_FG'].toString() == '040' ? '공사성(신설)' :
                      controller.datasList[index]['IR_FG'].toString() == '060' ? '안전/환경' : '기타',
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.a969696)),
                    )
                  ],
                )
                    : Container(),
                controller.datasList.isNotEmpty ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(controller.datasList[index]['INS_FG'].toString() == 'S' ? '' : controller.datasList[index]['MACH_CODE'].toString() == '' ? '설비 외' : _test(index),
                        style: AppTheme.a16700
                            .copyWith(color: AppTheme.black)),
                  ],
                )
                    : Container(),
              ],
            ),
            const SizedBox(height: 8,),

            /// 설비 | 설비이상 - 가동조치중 | 전기팀 대충 그런거
            controller.datasList.isNotEmpty ?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(controller.datasList[index]['IR_TITLE'].toString(),
                                style: AppTheme.a16400
                                    .copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 4,),
                        Text('|', style: AppTheme.a16400
                            .copyWith(color: AppTheme.a6c6c6c)),
                        const SizedBox(width: 4,),
                        Container(
                          child: Text(controller.datasList[index]['INS_DEPT'] == '20040' ? '전산팀' : controller.datasList[index]['INS_DEPT'] == '30020' ? '생산팀' : controller.datasList[index]['INS_DEPT'] == '30030' ? '공무팀' :
                          controller.datasList[index]['INS_DEPT'] == '30040' ? '전기팀' : controller.datasList[index]['INS_DEPT'] == '30050' ? '안전환경팀' : controller.datasList[index]['INS_DEPT'] == '30060' ? '품질팀' :
                              controller.datasList[index]['INS_DEPT'] == '99990' ? '기타' : '',
                              style: AppTheme.a16400
                                  .copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) : Container(),
            const SizedBox(height: 12,),
            controller.datasList.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('의뢰: ',
                        style: AppTheme.a14700
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.datasList[index]['IR_USER'].toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595)),
                    const SizedBox(width: 12,),
                    Container(
                        child: (() {
                          var firstIndex = controller.datasList[index]['IR_DATE']
                              .toString().lastIndexOf(':');
                          var lastIndex = controller.datasList[index]['IR_DATE']
                              .toString().length;
                          return Text(
                              controller.datasList[index]['IR_DATE']
                                  .toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, ''),
                              style: AppTheme.a14400
                                  .copyWith(color: AppTheme.a959595));
                        })()
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined, color: AppTheme.gray_c_gray_200, size: 20,),
                    const SizedBox(width: 4,),
                    Text(controller.datasList[index]['RESULT_FG'] == 'Y' ?
                        '${controller.datasList[index]['AFTER_TIME'].toString()}h 경과' : '${_dateDifference(index)}h 경과',
                        style: AppTheme.a14700
                            .copyWith(color: AppTheme.a969696)),
                  ],
                )
              ],
            ) : Container(),
            controller.datasList.isNotEmpty ?
            controller.datasList[index]['CHK_USER'] != null ?
            Row(
              children: [
                SizedBox(height: 4,),
                Text('확인: ',
                    style: AppTheme.a14700
                        .copyWith(color: AppTheme.a959595)),
                Text(controller.datasList[index]['CHK_USER'].toString(),
                    style: AppTheme.a14400
                        .copyWith(color: AppTheme.a959595)),
                const SizedBox(width: 12,),
                Container(
                    child: (() {
                      return Text(
                          controller.datasList[index]['CHK_DTM']
                              .toString(),
                          style: AppTheme.a14400
                              .copyWith(color: AppTheme.a959595));
                    })()
                ),
              ],
            ) : Container() : Container(),
            controller.datasList.isNotEmpty ?
            controller.datasList[index]['RE_USER'] != null ?
            Row(
              children: [
                SizedBox(height: 4,),
                Text('조치: ',
                    style: AppTheme.a14700
                        .copyWith(color: AppTheme.a959595)),
                Text(controller.datasList[index]['RE_USER'].toString(),
                    style: AppTheme.a14400
                        .copyWith(color: AppTheme.a959595)),
                const SizedBox(width: 12,),
                Container(
                    child: (() {
                      return Text(
                          controller.datasList[index]['RE_CRT_DATE']
                              .toString(),
                          style: AppTheme.a14400
                              .copyWith(color: AppTheme.a959595));
                    })()
                ),
              ],
            ) : Container() : Container()
          ],
        ),
      ),)
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
            onPressed: controller.isLoading.value ? null : () {
              Get.log('신규 등록 클릭!!');
              Get.to(const FacilityFirstStep2Page());
            },
            child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    '신규',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            )),
      ),
    );
  }


  String _dateDifference(int index) {
    var start = controller.datasList[index]['IR_DATE'].toString().indexOf('.');
    var end = controller.datasList[index]['IR_DATE'].toString().length;
    var time = controller.datasList[index]['IR_DATE'].toString().replaceRange(start, end, '');
    var realDate = DateTime.parse(time);
    var times = DateTime.now().difference(realDate);
    Get.log('realDate $realDate');
    Get.log('times ${times.inHours.toString()}');
    Get.log('now ${DateTime.now()}');
    return times.inHours.toString();
  }

  String _dateDifference2(int index) {
    var time = controller.datasList[index]['RE_CRT_DATE'].toString();
    var realDate = DateTime.parse(time);
    var times = DateTime.now().difference(realDate);
    Get.log('realDate $realDate');
    Get.log('times ${times.inHours.toString()}');
    Get.log('now ${DateTime.now()}');
    return times.inHours.toString();
  }

  String _test(int index) {
      for(var u = 0; u < controller.machList.length; u++) {
        if(controller.machList[u]['MACH_CODE'].toString() == controller.datasList[index]['MACH_CODE'].toString()) {
         return controller.machList[u]['MACH_NAME'];
        }
      }

    return '';
  }

  String modifyMach() {
    for(var u = 0; u < controller.modifyMachList.length; u++) {
      if(controller.modifyMachList[u]['MACH_CODE'].toString() == controller.selectedContainer[0]['MACH_CODE'].toString()) {
        return controller.modifyMachList[u]['MACH_NAME'];
      }
    }
    return '전체';
  }

  void modifyEngineTeam() {
    controller.modifyEngineTeamList.map((e) {
      if(e['CODE'] ==controller.selectedContainer[0]['INS_DEPT']) {
        controller.modifyEngineTeamCdMap['CODE'] = e['CODE'];
        controller.modifyEngineTeamCdMap['TEXT'] = e['TEXT'];
      }else {
        controller.modifyEngineTeamCdMap['CODE'] =  '9999';
        controller.modifyEngineTeamCdMap['TEXT'] = '기타';
      }
      Get.log('modifyEngineTeamCdMap::: ${controller.modifyEngineTeamCdMap} 선택!!!!');
    }).toList();
  }




}
