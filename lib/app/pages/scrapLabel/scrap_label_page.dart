import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/scrapLabel/bottomSheet.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';


class ScrapLabelPage extends StatelessWidget {
  ScrapLabelPage({Key? key}) : super(key: key);

  ScrapLabelController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  final ScrollController myScrollWorks = ScrollController();
  final focusNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.handled; // prevent passing the event into the TextField
    }
    return KeyEventResult.ignored; // pass the event to the TextField
  });
  final focusNode2 = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.handled; // prevent passing the event into the TextField
    }
    return KeyEventResult.ignored; // pass the event to the TextField
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '스크랩 라벨발행', isLogo: false, isFirstPage: true ),
            _bodyArea(context),
            //_streamBuilder()

          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 라벨 발행
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: /*Obx(() => */Container(
          color: AppTheme.white,
          child: Column(
            children: [
              _inputArea(context),
            ],
          ),
        ),/*)*/
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

  /// 매입과 외주 차이 = 외주스크랩 유무
  /// 공정회수와 매입 차이 = 공정정보 대신 계량정보 빼기
  Widget _inputArea(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 4,),
            _dropDownItem(context, '구분', 1),
            controller.selectedGubun.value == '지금류' ?
            Container() :
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    _dropDownItem(context, '유형', 2),
                  ],
                ),
            controller.selectedScrapType.value == '공정회수' ? Container() :
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    _topAreaTest(), // 계량정보
                  ],
                ),
            controller.selectedGubun.value == '지금류' ?
            Container() :
            Column(
              children: [
                controller.selectedScrapType.value == '매입' || controller.selectedScrapType.value == '외주' ?
                    Container() :
                    Column(
                      children: [
                        const SizedBox(height: 20,),
                        _industryItem('공정정보', 1), // 수량이랑 단위중량도 안보이게
                      ],
                    ),
                controller.selectedScrapType.value == '외주' ?
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    _areaOtherScrap(),
                  ],
                ) :
                Container(),
                const SizedBox(height: 20,),
                _dropDownItem(context, '도금', 3),
                const SizedBox(height: 20,),
                _industryItem('스크랩품명', 2),
                const SizedBox(height: 20,),
              ],
            ),
            controller.selectedGubun.value == '지금류' ? /// 이건 고정 바꿀 필요 없음
            Column(
              children: [
                const SizedBox(height: 20,),
                _industryItem('지금류품명', 3),
                const SizedBox(height: 20,),
              ],
            ) : Container(),
            _locationArea(),
            const SizedBox(height: 20,),
            controller.selectedGubun.value == '지금류' ? /// 이건 고정 바꿀 필요 없음
            Column(
              children: [
                _qtyArea(),
                const SizedBox(height: 20,),
              ],
            ) : Container(),
            controller.selectedGubun.value == '지금류' ?
            Container() :
            Column(
              children: [
                _weighing(),
                const SizedBox(height: 12,),
                _weighingTwo(),
                const SizedBox(height: 20,),
              ],
            ),
            _minusWeight(),
            const SizedBox(height: 100,),
            const SizedBox(height: 45,),

          ],
        ),
      ),
    ));
  }


  Widget _dropDownItem(BuildContext context, String text, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
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
                      color: AppTheme.light_placeholder,
                    ),
                    dropdownColor: AppTheme.light_ui_01,
                    value: flag == 1 ? controller.selectedGubun.value :
                    flag == 2 ? controller.selectedScrapType.value :
                      flag == 3 ? controller.selectedGold.value : '',
                    items: flag == 1 ? controller.scrapGubunList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 2 ?
                    controller.scrapTypeList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 3 ?
                    controller.goldList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : null,
                    onChanged: (value) async {
                      flag == 1 ?
                      controller.selectedGubun.value = value! :
                      flag == 2 ?
                      controller.selectedScrapType.value = value! :
                      flag == 3 ?
                      controller.selectedGold.value = value! : Get.log('$value 선택!!!!');

                      /// 스크랩 선택으로 인한 적재위치 리스트 변경
                     if(flag == 1 && controller.selectedGubun.value == '지금류') {
                       try{
                         controller.matlGb.value = '1';
                         await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_RACK', '@p_WHERE1':'W02'}).then((value) => // // 적재위치(지금류)
                         {
                           controller.selectedScLocMap['RACK_BARCODE'] = value['RESULT']['DATAS'][0]['DATAS'][0]['RACK_BARCODE'],
                           controller.selectedScLocMap['NAME'] =value['RESULT']['DATAS'][0]['DATAS'][0]['NAME'],
                           controller.scLocList.value = value['RESULT']['DATAS'][0]['DATAS'],
                         });
                       }catch(e) {
                         print('USP_SCS0300_R01 err -----> $e');
                         controller.selectedScLocMap['NAME'] = '네트워크 에러';
                       }
                     }
                      Get.log('${controller.scLocList.value} 선택!!!!');
                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),

              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _topAreaTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('계량정보',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8),
                child: Center(
                  child: Container(

                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppTheme.gray_gray_200),
                      ),
                    ),
                    child: /*RawKeyboardListener(
                      focusNode: focusNode,
                      onKey: (event) async{
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          controller.selectedContainer.clear();
                          var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SCALE', '@p_SCALE_ID': controller.weighingInfoTextController.text}).then((value) =>
                          {
                            if(value['DATAS'] != null) {
                              controller.measList.value = value['DATAS'],
                              Get.log('계량정보 스캔결과:::::: ${controller.measList.value}')
                            }
                          });
                          controller.textController.text = '';
                        }
                      },
                      child: */TextFormField(
                      style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                      // maxLines: 5,
                      controller: controller.weighingInfoTextController,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onTap: () {
                        if(controller.focusCnt.value++ > 1) controller.focusCnt.value = 0;
                        else Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                      },
                      onTapOutside:(event) => { controller.focusCnt.value = 0 },
                      onFieldSubmitted: (value) async {
                        Get.log('조회 돋보기 클릭!');
                        controller.selectedContainer.clear();
                        var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SCALE', '@p_SCALE_ID': controller.weighingInfoTextController.text}).then((value) =>
                        {
                          if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                            controller.measList.value = value['RESULT']['DATAS'][0]['DATAS'],
                            Get.log('계량정보 스캔결과:::::: ${controller.measList.value}')
                          }
                        });
                        Get.log('계량정보 스캔결과:::::: $a');
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () async {
                              Get.log('조회 돋보기 클릭!');
                              var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SCALE', '@p_SCALE_ID': controller.weighingInfoTextController.text}).then((value) =>
                              {
                                if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                                  controller.measList.value = value['RESULT']['DATAS'][0]['DATAS'],
                                  Get.log('계량정보 스캔결과:::::: ${controller.measList.value}')
                                }
                              });
                              Get.log('계량정보 스캔결과:::::: ${a}');
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


                    ),)
                  ),
              ),
            ),
            InkWell(
                onTap: () async {
                  Get.bottomSheet(
                      backgroundColor: AppTheme.white,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
                      BottomSheetModal()
                  );
                },
                child: const Icon(Icons.list_alt_outlined,size: 35, color: AppTheme.a6c6c6c,)
            )
          ],
        ),
        controller.measList.isNotEmpty || controller.selectedContainer.isNotEmpty ?
        Column(
          children: [
            const SizedBox(height: 12,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_c_gray_200),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('차량번호', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text(controller.selectedContainer.isNotEmpty ? '${controller.selectedContainer[0]['CAR_NO']}' : '${controller.measList[0]['CAR_NO']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('거래처명', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text(controller.selectedContainer.isNotEmpty ? '${controller.selectedContainer[0]['NAME']}' :'${controller.measList[0]['CUST_NM']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('거래처 ID', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text(controller.selectedContainer.isNotEmpty ? '${controller.selectedContainer[0]['CST_ID']}' :'${controller.measList[0]['CST_ID']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),

                        ],
                      ),
                    )
                ),
              ],
            ),
          ],
        ) : Container()
      ],
    );
  }



  Widget _industryItem(String text, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
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
                    value: flag == 1 ? controller.selectedIndustryMap['NAME']
                      : flag == 2 ? controller.selectedScrapNmMap['NAME'] :
                      controller.selectedRmNmMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: flag == 1 ? controller.industryList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 2 ? controller.scrapNmList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() :
                    controller.rmNmList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      flag == 1 ?
                      controller.industryList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedIndustryMap['CODE'] = e['CODE'];
                          controller.selectedIndustryMap['NAME'] = e['NAME'];
                        }
                      }).toList() : flag == 2 ?
                      controller.scrapNmList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScrapNmMap['CODE'] = e['CODE'];
                          controller.selectedScrapNmMap['NAME'] = e['NAME'];
                        }
                      }).toList() :
                      controller.rmNmList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedRmNmMap['CODE'] = e['CODE'];
                          controller.selectedRmNmMap['NAME'] = e['NAME'];
                        }
                      }).toList();
                      Get.log('${ controller.selectedScrapNmMap} 선택!!!!');
                      Get.log('${ controller.selectedIndustryMap} 선택!!!!');
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _areaOtherScrap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('외주스크랩',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppTheme.gray_gray_200),
                      ),
                    ),
                    child:/* RawKeyboardListener(
                      focusNode: focusNode2,
                      onKey: (event) async{
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_OUTS_NO', '@p_SCRAP_NO':  controller.otherScrapTextController.text}).then((value) =>
                          {
                            if(value['DATAS'] != null) {
                              controller.outScrapList.value = value['DATAS']
                            }
                          });
                          controller.textController.text = '';
                        }
                      },
                      child: */TextFormField(
                      style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                      // maxLines: 5,
                      controller: controller.otherScrapTextController,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onTap: () {
                        if(controller.focusCnt.value++ > 1) controller.focusCnt.value = 0;
                        else Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                      },
                      onTapOutside:(event) => { controller.focusCnt.value = 0 },
                      onFieldSubmitted: (value) async{
                        Get.log('조회 돋보기 클릭!');
                        var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_OUTS_NO', '@p_SCRAP_NO':  controller.otherScrapTextController.text}).then((value) =>
                        {
                          if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                            controller.outScrapList.value = value['RESULT']['DATAS'][0]['DATAS']
                          }
                        });
                        Get.log('외주스크랩 결과: $a');
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () async {
                              Get.log('조회 돋보기 클릭!');
                              var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_OUTS_NO', '@p_SCRAP_NO':  controller.otherScrapTextController.text}).then((value) =>
                              {
                                if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                                  controller.outScrapList.value = value['RESULT']['DATAS'][0]['DATAS']
                                }
                              });
                              Get.log('외주스크랩 스캔결과:::::: $a');
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
          ],
        ),
        controller.outScrapList.isNotEmpty ?
        Column(
          children: [
            const SizedBox(height: 12,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_c_gray_200),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('스크랩 품명', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text('${controller.outScrapList[0]['ITEM_NAME']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('스크랩 품명코드', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text(' ${controller.outScrapList[0]['ITEM_CODE']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('스크랩 세부유형', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text('${controller.outScrapList[0]['SCRAP_FG']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('도금 정보', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              Text('${controller.outScrapList[0]['PLATE_FG']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),

                        ],
                      ),
                    )
                ),
              ],
            ),
          ],
        ) : Container()
      ],
    );
  }


  Widget _locationArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.gray_gray_200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('적재창고',
                    style: AppTheme.a15700
                        .copyWith(color: AppTheme.black)),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: Text(controller.selectedGubun.value == '지금류' ? '원자재창고'
                      : controller.selectedGubun.value == '스크랩' ? '스크랩창고' : '자동입력', style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('적재위치',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
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
                    value: controller.selectedScLocMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.scLocList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.scLocList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScLocMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                          controller.selectedScLocMap['NAME'] = e['NAME'];
                        }
                      }).toList();
                      Get.log('${ controller.selectedScLocMap} 선택!!!!');
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _qtyArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.gray_gray_200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('수량',
                    style: AppTheme.a15700
                        .copyWith(color: AppTheme.black)),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppTheme.gray_gray_200),
                      )),
                  width: double.infinity,
                  child: TextFormField(
                    style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                    // maxLines: 5,
                    controller: controller.qtyTextController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '수량을 입력해주세요',
                      hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                      border: InputBorder.none,
                    ),
                    showCursor: true,

                    // onChanged: ((value) => controller.submitSearch(value)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.gray_gray_200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('단위중량',
                    style: AppTheme.a15700
                        .copyWith(color: AppTheme.black)),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppTheme.gray_gray_200),
                      )),
                  width: double.infinity,
                  child: TextFormField(
                    style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                    // maxLines: 5,
                    controller: controller.partWeiTextController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '단위중량을 입력해주세요',
                      hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                      border: InputBorder.none,
                    ),
                    showCursor: true,

                    // onChanged: ((value) => controller.submitSearch(value)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _weighing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('계근중량 / 설통번호 / 설통중량',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
      //  const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            // maxLines: 5,
            controller: controller.weighingTextController,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '계근중량을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
      ],
    );
  }

  Widget _weighingTwo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
                height: 50,
                  width: 200,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton2(
                  dropdownStyleData: DropdownStyleData(
                      maxHeight: 300,
                      width: 200,
                      offset: Offset(25, 25),
                      decoration: BoxDecoration(
                          color: AppTheme.light_ui_01,
                          border: Border(
                            bottom: BorderSide(color: AppTheme.gray_gray_200),
                          )
                      ),
                    ),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color:  AppTheme.gray_gray_200,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: SvgPicture.asset(
                          'assets/app/arrowBottom.svg',
                          color: AppTheme.light_placeholder,
                        ),
                      ),
                    ),
                 //   dropdownColor: AppTheme.light_ui_01,
                    value: controller.selectedTareMap['NAME'].toString(),
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.tareList.map((value) => DropdownMenuItem(
                        value: value['NAME'].toString(),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            value['NAME'].toString(),
                            style: AppTheme.a16400
                                .copyWith(color: value['NAME'].toString() == '설통번호 선택' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                          ),
                        )
                      )
                    ).toList(),
                    onChanged: (value) {
                      controller.tareList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedTareMap['CODE'] = e['CODE'];
                          controller.selectedTareMap['NAME'] = e['NAME'];
                          controller.selectedTareMap['WEIGHT'] = e['WEIGHT'].toString();
                        }
                      }).toList();
                      Get.log('${ controller.selectedTareMap} 선택!!!!');
                    },
                  dropdownSearchData: DropdownSearchData(
                    searchController: controller.searchDropTextController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        style: AppTheme.a14500.copyWith(color: AppTheme.black),
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.visiblePassword,
                        expands: true,
                        maxLines: null,
                        controller: controller.searchDropTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: '검색해주세요',
                          hintStyle: const TextStyle(fontSize: 12, color: AppTheme.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value.toString().contains(searchValue);
                    },
                  ),
                    )

                /*DropdownButton(
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
                    value: controller.selectedTareMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.tareList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '설통번호 선택' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.tareList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedTareMap['CODE'] = e['CODE'];
                          controller.selectedTareMap['NAME'] = e['NAME'];
                          controller.selectedTareMap['WEIGHT'] = e['WEIGHT'].toString();
                        }
                      }).toList();
                      Get.log('${ controller.selectedTareMap} 선택!!!!');
                    }),*/
              ),
        ),
        const SizedBox(width: 12,),
    /*    Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppTheme.gray_gray_200),
                  )),
              padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12, left: 12),
              child: Text(controller.selectedTareMap['WEIGHT'] != '' ? '${controller.selectedTareMap['WEIGHT']}' : '자동선택', style: AppTheme.a16400
                  .copyWith(color: AppTheme.a6c6c6c),),
            )
        ),*/
        Expanded(
          child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12, left: 12),
                child: Text(controller.selectedTareMap['WEIGHT'] != '' ? '${controller.selectedTareMap['WEIGHT']}' : '자동선택', style: AppTheme.a16400
                    .copyWith(color: AppTheme.a6c6c6c),),
              )
        ),
      ],
    );
  }

  Widget _minusWeight() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.gray_gray_200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('차감중량',
                    style: AppTheme.a15700
                        .copyWith(color: AppTheme.black)),
                const SizedBox(height: 10,),
                controller.selectedGubun.value == '지금류' ?
                Container(
                  padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: Text(controller.qtyTextController.text != '' && controller.partWeiTextController.text != ''
                      ? '${int.parse(controller.qtyTextController.text) * int.parse(controller.partWeiTextController.text)}': '자동입력', style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),),
                ) :
                Container(
                  padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: controller.selectedTareMap['NAME'] == '설통번호 선택' ? Text(controller.weighingTextController.text, style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c)) : Text(controller.weighingTextController.text != '' && controller.selectedTareMap['WEIGHT'] != ''
                    ? int.parse(controller.weighingTextController.text) >= int.parse('${controller.selectedTareMap['WEIGHT']}') ?
                  '${int.parse(controller.weighingTextController.text) - int.parse('${controller.selectedTareMap['WEIGHT']}')}': '다시 입력해주세요' : '', style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

/*bool isButton = false;*/

  Widget _bottomButton(BuildContext context) {
/*    if(isButton) return Container();
    isButton = true;*/
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: (() {
          return controller.isEndLabel.value == false ? InkWell(
              onTap: () async {
                if (controller.isFirstDuplication.value == false){
                  controller.isFirstDuplication.value = true;
                  controller.checkLogic();
                  controller.isLabelBtn.value ? controller.selectedGubun.value == '지금류' ? {await controller.saveButton(context),  controller.isFirstDuplication.value ?
                    await controller.PrintAlpha_3RB("SCRAP_LBL",{"SCRAP_NO": controller.scrapNo.value }, context) : null}
                      : {await controller.scrapSaveButton(context) ,  controller.isFirstDuplication.value
                      ?  await controller.PrintAlpha_3RB("SCRAP_LBL",{"SCRAP_NO": controller.scrapNo.value}, context) : null}
                          : _showDialog(context, '라벨발행');
                }
                Get.log('중복클릭 test');
              /*  controller.checkLogic();
                controller.isLabelBtn.value ? controller.selectedGubun.value == '지금류' ? await controller.saveButton(context) :  await controller.scrapSaveButton(context) : _showDialog(context, '라벨발행');*/
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.a1f1f1f
                ),
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      '라벨발행',
                      style: AppTheme.bodyBody2.copyWith(
                        color: const Color(0xfffbfbfb),
                      ),
                    )),
              ))
              : Row(
            children: [
              InkWell(
                  onTap: () async {
                    if (controller.isClearDuplication.value == false){
                      controller.isClearDuplication.value = true;
                      Get.offAllNamed(Routes.SCRAP_LABEL);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.light_cancel_press
                    ),
                    height: 56,
                    width: MediaQuery.of(context).size.width/2 - 24,
                    child: Center(
                        child: Text(
                          '초기화',
                          style: AppTheme.bodyBody2.copyWith(
                            color: const Color(0xfffbfbfb),
                          ),
                        )),
                  )),
              SizedBox(width: 16,),
              InkWell(
                  onTap: () async {
                    if (controller.isSecondDuplication.value == false){
                      controller.isSecondDuplication.value = true;
                      controller.reButton(context);
                      Future.delayed(Duration(seconds: 3), (){
                        controller.isSecondDuplication.value = false;
                      });
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.a1f1f1f
                    ),
                    height: 56,
                    width: MediaQuery.of(context).size.width/2 - 24,
                    child: Center(
                        child: Text(
                          '재발행',
                          style: AppTheme.bodyBody2.copyWith(
                            color: const Color(0xfffbfbfb),
                          ),
                        )),
                  ))
            ],
          );
        })()
    ));
  }
  void _showDialog(BuildContext context, String title) {
    showDialog(
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
                    title,
                    style: AppTheme.a18700
                        .copyWith(color: AppTheme.black),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: SizedBox(
                height: 50,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('필요 정보', style: AppTheme.a15800.copyWith(color: AppTheme.red_red_800),),
                        Text('들을 ', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                        Text('전부 ', style: AppTheme.a15800.copyWith(color: AppTheme.red_red_800),),
                        Text('기입해주세요', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                      ],
                    )
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
                              Get.log('확인 클릭!');
                              Get.back();
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
  }
}
