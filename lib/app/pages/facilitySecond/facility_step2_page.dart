import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';

import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class FacilityStep2Page extends StatelessWidget {
  FacilityStep2Page({Key? key}) : super(key: key);

  FacilityController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  final ScrollController myScrollWorks = ScrollController();
  final ScrollController myScrollWorks2 = ScrollController();


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () {
        return _onBackKey(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CommonAppbarWidget(title: '설비/안전 점검 - 정비내역 등록', isLogo: false, isFirstPage: false, facilityFlag: false ),
              _bodyArea(context),
             //_streamBuilder()

            ],
          ),
        ),
        bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }

  Future<bool> _onBackKey(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                  Text(
                    '',
                    style: AppTheme.a18700
                        .copyWith(color: AppTheme.black),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: SizedBox(
                height: 70,
                child: Column(
                  children: [
                    Text('저장되지 않은 내역이 있을 수 있습니다.', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                    Text('계속하시겠습니까?', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                  ],
                ),
              ),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0x5c3c3c43),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () {
                              Get.log('취소 클릭!');
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: const Color(0x5c3c3c43),)
                                  )
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacing_s_12,
                                bottom: AppTheme.spacing_s_12,
                              ),
                              child: Center(
                                child: Text('취소',
                                    style: AppTheme.titleHeadline.copyWith(
                                        color: AppTheme.black,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () {
                              Get.log('확인 클릭!');
                              Get.offAllNamed(Routes.FACILITY);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacing_s_12,
                                bottom: AppTheme.spacing_s_12,
                              ),
                              child: Center(
                                child: Text('확인',
                                    style: AppTheme.titleHeadline.copyWith(
                                        color: AppTheme.black,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]);
        });
    return false;
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          child: Column(
            children: [
              _topDataItem(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                color: AppTheme.gray_gray_100,
              ),
              _inputArea(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                color: AppTheme.gray_gray_100,
              ),
              _partChoiceBody(context),
              _otherPartInputBody(context),
            ],
          ),
        ),)
    );
  }

  /*Widget _streamBuilder() {
    return SliverToBoxAdapter(
      child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (c, snapshot) {
            return Container(
              child: (() {
                controller.step2RegistBtn();
              }()),
            );
          }),
    );
  }
*/
  Widget _topDataItem() {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: controller.selectedContainer[0]['URGENCY_FG'] == 'U' ? AppTheme.afef1ef :
                        AppTheme.aecf9f2
                    ),
                    child: Text(controller.selectedContainer[0]['URGENCY_FG'] == 'U' ? '긴급' : '보통', /// 긴급 or 보통 으로
                        style: AppTheme.bodyBody1
                            .copyWith(color: controller.selectedContainer[0]['URGENCY_FG'] == 'U' ? AppTheme.af34f39 : AppTheme.a18b858)),
                  ),
                  const SizedBox(width: 6,),
                  Container(
                    padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:  AppTheme.af4f4f4
                    ),

                    child: Text( controller.selectedContainer[0]['INS_FG'] == 'M' ? '설비점검' : '안전점검',
                        style: AppTheme.bodyBody1
                            .copyWith(color: AppTheme.a969696)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_machName(),
                      style: AppTheme.a22700
                          .copyWith(color: AppTheme.black)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.selectedContainer[0]['IR_TITLE'].toString(),
                  style: AppTheme.a18400
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            height: 1, color: AppTheme.gray_c_gray_100,
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('번호',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['IR_CODE']}',
                            style: AppTheme.a16400
                                .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('의뢰자',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['IR_USER']}',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('점검부서',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text(controller.selectedContainer[0]['INS_DEPT'] == '20040' ? '전산팀' : controller.selectedContainer[0]['INS_DEPT'] == '30020' ? '생산팀' : controller.selectedContainer[0]['INS_DEPT'] == '30030' ? '공무팀' :
              controller.selectedContainer[0]['INS_DEPT'] == '30040' ? '전기팀' : controller.selectedContainer[0]['INS_DEPT'] == '30060' ? '품질팀' :
              controller.selectedContainer[0]['INS_DEPT'] == '99990' ? '기타' : '',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('구분',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['INS_FG'].toString() == 'M' ? '설비' : '안전'}',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('정비유형',
                  style: AppTheme.bodyBody1
                      .copyWith(color: AppTheme.light_text_tertiary, fontSize: 18)),
              Container(
                  child: (() {
                    return Text(
                        controller.selectedContainer[0]['IR_FG'].toString(),
                        style: AppTheme.bodyBody2
                            .copyWith(color: AppTheme.black));
                  })()
              ),
            ],
          ),
          const SizedBox(height: 12,),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('장애일시',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Container(
                  child: (() {
                    var firstIndex = controller.selectedContainer[0]['IR_DATE']
                        .toString().lastIndexOf(':');
                    var lastIndex = controller.selectedContainer[0]['IR_DATE']
                        .toString().length;
                    return Text(
                        controller.selectedContainer[0]['IR_DATE']
                            .toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, ''),
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black));
                  })()
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('경과시간',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text(controller.selectedContainer[0]['RESULT_FG'] == 'Y' ?
              '${controller.selectedContainer[0]['AFTER_TIME'].toString()}h' :'${_dateDifference()}h',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 40,),

        ],
      ),
    );
  }

  Widget _inputTitle(String title) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Text(title, style: AppTheme.titleSubhead4.copyWith(color: AppTheme.black),),
        )
    );
  }

  Widget _inputArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Obx(() => _inputEngineerItem(context)),
            SizedBox(height: 40,),
            Row(
              children: [

                _inputTitle('정비상태'),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                _dropDownItem(context, 2),
              ],
            ),
            SizedBox(height: 25,),
            controller.selectedResultFg.value == '미조치' ?
                Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        _inputTitle('미조치 사유'),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      children: [
                        _dropDownItem(context,  3),
                      ],
                    ),
                  ],
                ) : Container(),
            SizedBox(height: 40,),
            _startEndCalendarItem(context),
            SizedBox(height: 60,),
            _engineContentItem(),
            SizedBox(height: 70,),
          ],
        ),
      ),
    );
  }

  Widget _inputEngineerItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비자',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        InkWell(
          onTap: () {
             controller.showModalUserChoice(context: context);
          },
          child: Container(
            decoration: BoxDecoration(
                border: const Border(
                    bottom:
                    BorderSide(color: AppTheme.light_ui_08),
                   )),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(right: 12, top: 16, bottom: 16),
            child: Text(controller.selectedEnginner.value, style: AppTheme.bodyBody1.copyWith(
                color: controller.selectedEnginner.value == '정비자를 선택해주세요'
                    ?AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),)

          ),
        ),

      ],
    );
  }

  Widget _dropDownItem(BuildContext context, int flag) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: const Border(
              bottom:
              BorderSide(color: AppTheme.light_ui_08),
            )),
        padding: const EdgeInsets.only(right: 12),
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
                  value: flag == 1 ? controller.selectedIrFq.value :
                        flag == 2 ? controller.selectedResultFg.value : controller.selectedNoReason.value,
                      //  flag == 3 ? controller.selectedNoReason.value :
                  items: flag == 1 ? controller.irfgList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList() : flag == 2 ?
                  controller.resultFgList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '전체' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList() : controller.noReasonList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    flag == 1 ?
                    controller.selectedIrFq.value = value! :
                    flag == 2 ?
                    controller.selectedResultFg.value = value! :
                    controller.selectedNoReason.value = value!;


                    Get.log('$value 선택!!!!');
                    Get.log('$value 선택!!!!');
                   // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                  }),

      ),
    );
  }
  /// 정비날짜 정하기
  Widget _startEndCalendarItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비날짜',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 12,),
        Row(
          children: [
            Expanded(
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  onPressed: () async{
                    var datePicked = await DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                         // controller.isErrorDateChoice.value = false;
                          var firstIndex = date
                              .toString().lastIndexOf(':');
                          var lastIndex = date
                              .toString().length;
                          controller.dayStartValue.value = date.toString().replaceRange(firstIndex, lastIndex, '');
                        }, currentTime: DateTime.now(), locale: LocaleType.ko);

                    Get.log('${datePicked}');
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(bottom:  BorderSide(color: AppTheme.light_ui_08),)
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(controller.dayStartValue.value, style: AppTheme.a17400
                            .copyWith(color: AppTheme.black),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12,),
            Container(height: 50, child: Center(
              child: Text('~',style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
            ),),
            SizedBox(width: 12,),
            Expanded(
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  onPressed: () async{
                    var datePicked = await DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          // controller.isErrorDateChoice.value = false;
                          var firstIndex = date
                              .toString().lastIndexOf(':');
                          var lastIndex = date
                              .toString().length;
                          controller.dayEndValue.value = date.toString().replaceRange(firstIndex, lastIndex, '');
                        }, currentTime: DateTime.now(), locale: LocaleType.ko);

                    Get.log('${datePicked}');
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(bottom:  BorderSide(color: AppTheme.light_ui_08),)
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(controller.dayEndValue.value, style: AppTheme.a17400
                            .copyWith(color: AppTheme.black),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )



      ],
    );
  }


  Widget _engineContentItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비내용',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 24,),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.black)
            ),
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
              maxLength: 100,
              maxLines: 5,
              controller: controller.textContentController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17, color: AppTheme.gray_gray_400),
                fillColor: Colors.white,
                filled: true,
                hintText: '내용을 입력해주세요',
                border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0)
              ),
              
              showCursor: true,

              // onChanged: ((value) => controller.submitSearch(value)),
            ),
          ),
      ],
    );
  }

  Widget _partChoiceBody(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 24),
      child: Column(
          children: [
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('사용부품 정보 등록',
                        style: AppTheme.titleHeadline
                            .copyWith(color: AppTheme.black)),
                TextButton(
                  style: ButtonStyle(
                    /*backgroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.light_success
                    ),*/
                    padding: MaterialStateProperty.all(EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(100)
                        )),
                  ),
                  onPressed: () async{
                    Get.log('추가');
                    controller.showModalPartChoice(context: context);
                  },
                  child: Container(
                        padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_gray_300)
                        ),
                        child: Center(
                          child: Text('추가/삭제', style: AppTheme.bodyBody1.copyWith(color: AppTheme.light_text_secondary),),
                        ),
                      ),
                ),
                  //  SizedBox(width: 4,),
                    /*Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                      color: AppTheme.light_cancel,
                      child: Center(
                        child: Text('삭제', style: AppTheme.bodyBody1.copyWith(color: AppTheme.white),),
                      ),
                    )*/

              ],
            ),
            controller.partSelectedList.length != 0 ? Container(
              height: 200,
              child: PrimaryScrollController(
                controller: myScrollWorks,
                child: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  controller.partSelectedList.length != 0 ?
                  _listArea() : SliverToBoxAdapter( child: Container(),)
                ],
              ),
            ),)) : Container(),
           //  SizedBox(height: 40,)
          ],
      ),
    );
  }

  Widget _otherPartInputBody(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24,),
          Text('부품재고 외 추가 부품',
                  style: AppTheme.titleHeadline
                      .copyWith(color: AppTheme.black)),
          SizedBox(height: 12,),
          Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.ae2e2e2),
                            ),
                    width: double.infinity,
                            child: TextFormField(
                              style:  AppTheme.a15500.copyWith(color: AppTheme.a6c6c6c),
                              // maxLines: 5,
                              controller: controller.textItemNameController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: '품명 입력',
                                hintStyle: AppTheme.a15500.copyWith(color: AppTheme.aBCBCBC),
                                border: InputBorder.none,
                              ),
                              showCursor: true,

                              // onChanged: ((value) => controller.submitSearch(value)),
                            ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.ae2e2e2),
                    ),
                    width: double.infinity,
                    child: TextFormField(
                      style:  AppTheme.a15500.copyWith(color: AppTheme.a6c6c6c),
                      // maxLines: 5,
                      controller: controller.textItemSpecController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'SPEC 입력',
                        hintStyle: AppTheme.a15500.copyWith(color: AppTheme.aBCBCBC),
                        border: InputBorder.none,
                      ),
                      showCursor: true,

                      // onChanged: ((value) => controller.submitSearch(value)),
                    ),
                  ),

                ],
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      children: [
                        Text('수량', style: AppTheme.a14400.copyWith(color: AppTheme.black),),
                        InkWell(
                          onTap: () {
                            if(controller.otherPartQty.value > 1) {
                              controller.otherPartQty.value = controller.otherPartQty.value - 1;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 12 , left: 10),
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.red_red_200
                                ),
                                child: SvgPicture.asset('assets/app/minus.svg', width: 12, height: 12, color: AppTheme.red_red_900,)),
                          ),
                        ),
                        SizedBox(width: 12,),
                        //Text('사용 ', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                        Text('${controller.otherPartQty.value}', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                        SizedBox(width: 12,),
                        InkWell(
                          onTap: () {
                            controller.otherPartQty.value = controller.otherPartQty.value + 1;

                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 12 , right: 10),
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.blue_blue_200
                                ),
                                child: SvgPicture.asset('assets/app/plus.svg', width: 12, height: 12, color: AppTheme.blue_blue_900,)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                          )),
                    ),
                    onPressed: () async{
                      Get.log('추가');
                      controller.otherPartList.add({'ITEM_SPEC': controller.textItemSpecController.text
                        , 'ITEM_NAME': controller.textItemNameController.text, 'QTY': controller.otherPartQty.value});
                      controller.textItemSpecController.clear();
                      controller.textItemNameController.clear();
                      controller.otherPartQty.value = 1;
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_gray_300)
                      ),
                      child: Center(
                        child: Text('추가', style: AppTheme.bodyBody1.copyWith(color: AppTheme.light_text_secondary),),
                      ),
                    ),
                  ),

            ],
          ),
          Container(
              height: 200,
              child: PrimaryScrollController(
                controller: myScrollWorks2,
                child: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      controller.otherPartList.length != 0 ?
                      _otherPartListArea() : SliverToBoxAdapter( child: Container(),)
                    ],
                  ),
                ),)),
          SizedBox(height: 40,)
        ],
      ),
    );
  }

  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.partSelectedList.length));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 24, left: 8),
      child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppTheme.gray_gray_300)
                )
            ),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.partSelectedList[index]['ITEM_NAME']}',
                              style: AppTheme.a16400.copyWith(
                                color: AppTheme.a1f1f1f,
                              ),
                            ),
                            SizedBox(height: 6,),
                            Text(
                              '${controller.partSelectedList[index]['ITEM_SPEC']}',
                              style: AppTheme.a16400.copyWith(
                                color: AppTheme.a1f1f1f,
                              ),
                            ),

                      ],
                    ),
                    Text(
                      controller.partSelectedQtyList.isEmpty ? '1' :
                      '${controller.partSelectedQtyList[index]}',
                      style: AppTheme.a16400.copyWith(
                        color: AppTheme.a1f1f1f,
                      ),
                    )
                  ],
                ),

          ),
    );
  }

  Widget _otherPartListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _otherPartListItem(index: index, context: context);
        }, childCount: controller.otherPartList.length));
  }
  Widget _otherPartListItem({required BuildContext context,required int index}) {

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 20, right: 8),
                child: InkWell(
                  onTap: () {
                    controller.otherPartList.remove(controller.otherPartList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 12, top: 12 , left: 10),
                    child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppTheme.red_red_200
                        ),
                        child: SvgPicture.asset('assets/app/minus.svg', width: 12, height: 12, color: AppTheme.red_red_900,)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_300)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.otherPartList[index]['ITEM_NAME']}',
                        style: AppTheme.a16400.copyWith(
                          color: AppTheme.a1f1f1f,
                        ),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        '${controller.otherPartList[index]['ITEM_SPEC']}',
                        style: AppTheme.a16400.copyWith(
                          color: AppTheme.a1f1f1f,
                        ),
                      ),

                    ],
                  ),
                  Text(
                    '${controller.otherPartList[index]['QTY']}',
                    style: AppTheme.a16400.copyWith(
                      color: AppTheme.a1f1f1f,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
      child: (() {
        if(controller.selectedResultFg.value != '전체'
            && controller.selectedNoReason.value != '전체'
        && controller.selectedEnginner.value != '정비자를 선택해주세요' &&  controller.dayStartValue.value != '선택해주세요' &&
            controller.dayEndValue.value != '선택해주세요') {
          controller.isStep2RegistBtn.value = true;
        }else {
          controller.isStep2RegistBtn.value = false;
        }
        return TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                backgroundColor: controller.isStep2RegistBtn.value ?
                MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: controller.isStep2RegistBtn.value ? () async {
              controller.cdConvert();
              await controller.saveButton();

              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Get.dialog(
                    CommonDialogWidget(contentText: '저장되었습니다', pageFlag: 2,)
                );
              });
            } : null,
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    '저장',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            ));
      })()
    ));
  }
  String _machName() {
    for(var i = 0; i < controller.machList.length; i++) {
      if(controller.machList[i]['MACH_CODE'].toString() ==controller.selectedContainer[0]['MACH_CODE'].toString()) {
        return controller.machList[i]['MACH_NAME'];
      }

    }
    return '';
  }
  String _dateDifference() {
    var start = controller.selectedContainer[0]['IR_DATE'].toString().indexOf('.');
    var end = controller.selectedContainer[0]['IR_DATE'].toString().length;
    var time = controller.selectedContainer[0]['IR_DATE'].toString().replaceRange(start, end, '');
    var realDate = DateTime.parse(time);
    var times = DateTime.now().difference(realDate);
    Get.log('realDate $realDate');
    Get.log('times ${times.inHours.toString()}');
    Get.log('now ${DateTime.now()}');
    return times.inHours.toString();
  }


}
