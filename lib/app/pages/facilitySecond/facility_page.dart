import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_step2_page.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityPage extends StatelessWidget {
  FacilityPage({Key? key}) : super(key: key);

  FacilityController controller = Get.find();

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
                  CommonAppbarWidget(title: '설비/안전 점검 조회', isLogo: false, isFirstPage: true,),
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
             // _choiceButtonItem(),
              SizedBox(height: 24,),
              SizedBox(height: 12,),
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

              onTap: () async {
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
                  controller.step1DayStartValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    controller.selectedDatas.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG' : controller.selectedIrFqMap2['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                        for(var i = 0; i < controller.datasList.length; i++){
                          controller.selectedDatas.add(false)
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }



                }else {
                  controller.step1DayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                  controller.step1DayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                    Text(controller.step1DayStartValue.value, style: AppTheme.a12500
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
                  controller.step1DayEndValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    controller.selectedDatas.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.selectedIrFqMap2['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                        for(var i = 0; i < controller.datasList.length; i++){
                          controller.selectedDatas.add(false)
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }


                }else {
                  controller.step1DayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                  controller.step1DayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                    Text(controller.step1DayEndValue.value, style: AppTheme.a14500
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
        padding: EdgeInsets.only(left: 16, right: 12, top: 14, bottom: 14),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.ae2e2e2)
        ),
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
    return Obx(() => Row(
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
                    controller.selectedDatas.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.selectedIrFqMap2['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                        for(var i = 0; i < controller.datasList.length; i++){
                          controller.selectedDatas.add(false)
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
                    controller.selectedDatas.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                      , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.selectedIrFqMap2['CODE']}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                      if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                        controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                        for(var i = 0; i < controller.datasList.length; i++){
                          controller.selectedDatas.add(false)
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
    return Obx(()=>Expanded(
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
                for(var i = 0; i < controller.selectedDatas.length; i++) {
                  controller.selectedDatas[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                controller.selectedDatas.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.selectedIrFqMap2['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  controller.datasList.clear(),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                    for(var i = 0; i < controller.datasList.length; i++){
                      controller.selectedDatas.add(false)
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '미조치') {
                Get.log('미조치 클릭');
                controller.choiceButtonVal.value = 2;
                controller.pResultFg.value = 'N';
                for(var i = 0; i < controller.selectedDatas.length; i++) {
                  controller.selectedDatas[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                controller.selectedDatas.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG' : controller.selectedIrFqMap2['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                    for(var i = 0; i < controller.datasList.length; i++){
                      controller.selectedDatas.add(false)
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '정비완료') {
                Get.log('조치완료 클릭');
                controller.choiceButtonVal.value = 3;
                controller.pResultFg.value = 'Y';
                for(var i = 0; i < controller.selectedDatas.length; i++) {
                  controller.selectedDatas[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                controller.selectedDatas.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG' : controller.selectedIrFqMap2['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                    for(var i = 0; i < controller.datasList.length; i++){
                      controller.selectedDatas.add(false)
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '정비 진행중') {
                Get.log('정비 진행중 클릭');
                controller.choiceButtonVal.value = 4;
                controller.pResultFg.value = 'I';
                for(var i = 0; i < controller.selectedDatas.length; i++) {
                  controller.selectedDatas[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                controller.selectedDatas.clear();
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                  , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG' : controller.selectedIrFqMap2['CODE']}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                  if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                    controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                    for(var i = 0; i < controller.datasList.length; i++){
                      controller.selectedDatas.add(false)
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
    return Obx(() => Expanded(
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
            value: controller.selectedIrFqMap2['TEXT'],
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.step1IrfgList.map((value) {
              return DropdownMenuItem<String>(
                value: value['TEXT'],
                child: Text(
                  value['TEXT'],
                  style: AppTheme.a16400
                      .copyWith(color:  value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.step1IrfgList.map((e) {
                if(e['TEXT'] == value) {
                  controller.selectedIrFqMap2['TEXT'] = e['TEXT'];
                  controller.selectedIrFqMap2['CODE'] = e['CODE'];
                }

                //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
              }).toList();
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG': controller.selectedIrFqMap2['CODE']}).then((value) =>
              {
                Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                  controller.datasList.value = value['RESULT']['DATAS'][0]['DATAS'],
                  for(var i = 0; i < controller.datasList.length; i++){
                    controller.selectedDatas.add(false)
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
              controller.selectedDatas.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.step1DayStartValue.value}','@p_IR_DATE_TO':'${controller.step1DayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : controller.selectedReadEngineTeamMap['CODE']
                , '@p_RESULT_FG' : controller.pResultFg.value, '@p_IR_FG':  controller.irFgCd.value}).then((value) =>
              {
                Get.log('value[DATAS]: ${value['DATAS']}'),
                if(value['DATAS'] != null) {
                  controller.datasList.value = value['DATAS'],
                  for(var i = 0; i < controller.datasList.length; i++){
                      controller.selectedDatas.add(false)
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
            }),*/

      ),
    ));
  }


  Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.datasList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {

    return Obx(() => TextButton(
        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5)))),
        padding:
        MaterialStateProperty.all(const EdgeInsets.all(0))),
      onPressed: () {
        if(controller.selectedDatas[index] == true) {
          controller.selectedDatas[index] = false;
          controller.registButton.value = false;
          controller.selectedContainer.clear();
        }else {
          for(var i = 0; i < controller.selectedDatas.length; i++) {
            controller.selectedDatas[i] = false;
          }
          controller.selectedContainer.clear();
          controller.selectedDatas[index] = true;
          if(controller.selectedDatas[index] == true) {
            controller.registButton.value = true;
            controller.selectedContainer.add(controller.datasList[index]);
            controller.selectedContainer[0]['RP_CODE'] != null ||  controller.selectedContainer[0]['RP_CODE'] != '' ? controller.isAlreadySave.value = true : controller.isAlreadySave.value = false;
          }
        }
        Get.log('rrr${controller.selectedContainer}');
      },
      child: Container(

        margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
        padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_c_gray_100.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: controller.selectedDatas[index] ? Border.all(color: AppTheme.black, width: 3) : Border.all(color: AppTheme.ae2e2e2) ,
          color: AppTheme.white,
        ),
        child: Center(
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
                      SizedBox(width: 4,),

                      Container(
                        padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:  AppTheme.af4f4f4
                        ),

                        child: Text( controller.datasList[index]['INS_FG'].toString() == 'M' ? '설비점검' : '안전점검',
                            style: AppTheme.a12500
                                .copyWith(color: AppTheme.a969696)),
                      ),
                      SizedBox(width: 4,),
                      controller.datasList[index]['RESULT_FG'].toString() == '' ? Container() :
                      Container(
                        padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:  controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? Color(0xffF0FFFF) : Color(0xffFFFFE0)
                        ),

                        child: Text( controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? '정비완료'
                            : controller.datasList[index]['RESULT_FG'].toString() == 'I' ? '정비 진행중' :
                        controller.datasList[index]['RESULT_FG'].toString() == 'N' ? '미조치' : '',
                            style: AppTheme.a12500
                                .copyWith(color: controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? Color(0xff1E90FF) :  Colors.orangeAccent)),
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
                  /// 등록한 시간과 현재시간 비교
                  controller.datasList.isNotEmpty ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(controller.datasList[index]['INS_FG'] == 'S' ? '' : controller.datasList[index]['MACH_CODE'].toString() == '' ? '설비 외' : _test(index),
                          style: AppTheme.a16700
                              .copyWith(color: AppTheme.black)),
                    ],
                  )
                      : Container(),
                ],
              ),
              SizedBox(height: 8,),


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
                            Text(controller.datasList[index]['IR_TITLE'].toString(),
                                style: AppTheme.a16400
                                    .copyWith(color: AppTheme.a6c6c6c)),
                            SizedBox(width: 4,),
                            Text('|', style: AppTheme.a16400
                                .copyWith(color: AppTheme.a6c6c6c)),
                            SizedBox(width: 4,),
                            Text(controller.datasList[index]['INS_DEPT'] == '20040' ? '전산팀' : controller.datasList[index]['INS_DEPT'] == '30020' ? '생산팀' : controller.datasList[index]['INS_DEPT'] == '30030' ? '공무팀' :
                            controller.datasList[index]['INS_DEPT'] == '30040' ? '전기팀' : controller.datasList[index]['INS_DEPT'] == '30050' ? '안전환경팀' : controller.datasList[index]['INS_DEPT'] == '30060' ? '품질팀' :
                            controller.datasList[index]['INS_DEPT'] == '99990' ? '기타' : '',
                                style: AppTheme.a16400
                                    .copyWith(color: AppTheme.a6c6c6c)),
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
        ),
      ),
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

  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              backgroundColor: controller.registButton.value ?
              MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
              MaterialStateProperty.all<Color>(AppTheme.light_cancel),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
          onPressed: controller.isLoading.value ? null : controller.registButton.value ? () async{
            Get.log('점검의뢰 등록 클릭!!');
            try{
              controller.isLoading.value = true;
              await controller.reqEngineer();
              await controller.partConvert('${controller.selectedContainer[0]['MACH_CODE']}');
              await controller.reqAlreadyCpList();
              /// 정비내역이 있을 시
              if(controller.isAlreadyListData.value) {
                controller.insertAlreadyData();
                controller.isAlreadyListData.value = false;
              }
            }catch(err) {
              Get.log('err = ${err.toString()} ', isError: true);
            }finally {
              controller.isLoading.value = false;
            }
            /*controller.isAlreadySave.value == true ?  HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_RP_CODE':controller.selectedContainer[0]['RP_CODE']}).then((value) =>
            {
              controller.alreadyList.value = value['DATAS']
            }) : null;*/
            Get.to(FacilityStep2Page());
          } : null,
          child: Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
                  '정비내역 등록',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    ));
  }
}