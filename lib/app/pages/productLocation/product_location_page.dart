import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ProductLocationPage extends StatelessWidget {
  ProductLocationPage({super.key});

  ProductLocationController controller = Get.find();
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
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme.white,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                CommonAppbarWidget(title: '제품 위치이동', isLogo: false, isFirstPage: true ),
                _topAreaTest(context),
              //  _topArea(),
                _locationItem(context),
                _listArea()


              ],
            ),
          ),
          bottomNavigationBar: _bottomButton(context), //  등록
        ),
      ),
    );
  }


  Widget _topAreaTest(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 12, top: 4),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: /*RawKeyboardListener(
                    focusNode: focusNode,
                    onKey: (event) {
                    *//*  FocusScope.of(context).autofocus(focusNode);
                      String e = event.character ?? '';
                      if (e.isNotEmpty  || e == '-') {
                        controller.textController.text += e.trim();*//*
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          for(var i = 0; i < controller.locationList.length; i++) {
                            if( controller.textController.text == controller.locationList[i]['AREA']) {
                              controller.selectedLocationMap['RACK_BARCODE'] = controller.locationList[i]['RACK_BARCODE'];
                              controller.selectedLocationMap['AREA'] = controller.locationList[i]['AREA'];
                              controller.isAreaScan.value = true;
                              controller.textController.text = '';
                              return;
                            }else {
                              controller.isAreaScan.value = false;
                            }
                          }
                          if(controller.isAreaScan.value) {
                            null;
                          }else {
                            controller.textBc.value = controller.textController.text;
                            controller.checkButton();
                            controller.textController.text = '';
                          }
                          FocusScope.of(context).autofocus(focusNode);
                        }
                     // }
                    },
                    child: */TextFormField(
                      focusNode: focusNode2,
                    style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                    // maxLines: 5,
                    controller: controller.textController,
                    textAlignVertical: TextAlignVertical.center,
                    onTap: () {
                      if(controller.focusCnt.value++ > 1) controller.focusCnt.value = 0;
                      else Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                    },
                    onTapOutside:(event) => { controller.focusCnt.value = 0 },
                    onFieldSubmitted: (value) async{
                      for(var i = 0; i < controller.locationList.length; i++) {
                        if( controller.textController.text == controller.locationList[i]['AREA']) {
                          controller.selectedLocationMap['RACK_BARCODE'] = controller.locationList[i]['RACK_BARCODE'];
                          controller.selectedLocationMap['AREA'] = controller.locationList[i]['AREA'];
                          controller.isAreaScan.value = true;
                          controller.textController.text = '';
                          return;
                        }else {
                          controller.isAreaScan.value = false;
                        }
                      }
                      if(controller.isAreaScan.value) {
                        null;
                      }else {
                        controller.textBc.value = controller.textController.text;
                        controller.checkButton();
                        controller.textController.text = '';
                      }
                      focusNode2.requestFocus();
                      Future.delayed(const Duration(), (){
                        focusNode2.requestFocus();
                        //  FocusScope.of(context).requestFocus(focusNode);
                        Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            Get.log('조회 돋보기 클릭!');
                            for(var i = 0; i < controller.locationList.length; i++) {
                              if( controller.textController.text == controller.locationList[i]['AREA']) {
                                controller.selectedLocationMap['RACK_BARCODE'] = controller.locationList[i]['RACK_BARCODE'];
                                controller.selectedLocationMap['AREA'] = controller.locationList[i]['AREA'];
                                controller.isAreaScan.value = true;
                                controller.textController.text = '';
                                return;
                              }else {
                                controller.isAreaScan.value = false;
                              }
                            }
                            if(controller.isAreaScan.value) {
                              null;
                            }else {
                              controller.textBc.value = controller.textController.text;
                              controller.checkButton();
                              controller.textController.text = '';
                            }
                            focusNode2.requestFocus();
                            Future.delayed(const Duration(), (){
                              focusNode2.requestFocus();
                              //  FocusScope.of(context).requestFocus(focusNode);
                              Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                            });
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

        ],
      ),
    );
  }
  Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _bodyArea(index: index, context: context);
        }, childCount: controller.productList.length)));
  }


  Widget _bodyArea({required BuildContext context, required int index}) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.ae2e2e2),
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.white
            ),
            child: Obx(() => Column(
              children: [
                _bodyItem('BC No.', controller.productList.isEmpty ? '' : controller.productList[index]['BARCODE_NO'].toString()),
                const SizedBox(height: 12,),
                _bodyItem('거래처', controller.productList.isEmpty ? '' : controller.productList[index]['CST_NM'].toString()),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    _bodyItem('품종', controller.productList.isEmpty ? '' : controller.productList[index]['CMP_NM'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('R/P', controller.productList.isEmpty ? '' : controller.productList[index]['SHP_NM'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('질별', controller.productList.isEmpty ? '' : controller.productList[index]['STT_NM'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('두께', controller.productList.isEmpty ? '' : controller.productList[index]['THIC'].toString()),
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    _bodyItem('폭', controller.productList.isEmpty ? '' : controller.productList[index]['WIDTH'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('합불', controller.productList.isEmpty ? '' : controller.productList[index]['PASS'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('위치', controller.productList.isEmpty ? '' : controller.productList[index]['LOC_AREA'].toString()),
                    const SizedBox(width: 12,),
                    _bodyItem('무게', controller.productList.isEmpty ? '' : controller.productList[index]['WEIGHT'].toString()),
                  ],
                ),
              ],
            ),)
        ),
        SizedBox(height: 12,)
      ],
    );
  }

  Widget _bodyItem(String title, String content) {
    return Row(
      children: [
        Text('$title: ', style: AppTheme.a12500.copyWith(color: AppTheme.black)),
        Text(content, style: AppTheme.a12700.copyWith(color: AppTheme.black),)
      ],
    );
  }

  Widget _locationItem(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() => Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 24),
          // padding: EdgeInsets.only(left: 28, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이동위치',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
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
                          value: controller.selectedLocationMap['AREA'],
                          //  flag == 3 ? controller.selectedNoReason.value :
                          items: controller.locationList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value['AREA'].toString(),
                              child: Text(
                                value['AREA'].toString(),
                                style: AppTheme.a16400
                                    .copyWith(color: value['AREA'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                              ),
                            );
                          }).toList(),
                          onTap: () {
                            FocusScope.of(context).requestFocus(focusNode2);
                          },
                          onChanged: (value) {
                            controller.locationList.map((e) {
                              if(e['AREA'] == value) {
                                controller.selectedLocationMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                                controller.selectedLocationMap['AREA'] = e['AREA'];
                              }
                            }).toList();
                            Get.log('${ controller.selectedLocationMap} 선택!!!!');
                            FocusScope.of(context).requestFocus(focusNode2);
                          }),
                    ),
                  ),
                ],
              ),
            ],
          )
      )),
    );
  }
  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: (() {
          if(controller.selectedLocationMap['AREA'] != '선택해주세요') {
            if(controller.isBcCode.value == true) {
              controller.isButton.value = true;
            }
          }else {
            controller.isButton.value = false;
          }
          return TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: controller.isButton.value ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.isButton.value ? () {
                // 바코드 여러개 이동저장 처리
                for(var i = 0; i < controller.bcList.length; i++ ) {
                  controller.saveButton(i);
                }
               // controller.saveButton();
                Get.log('저장 버튼 클릭');
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Get.dialog(
                      CommonDialogWidget(contentText: '저장되었습니다', pageFlag: 3,)
                  );
                  controller.checkButton();
                  controller.textBc.value = '';
                });

              } : null,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      '이동 저장',
                      style: AppTheme.bodyBody2.copyWith(
                        color: const Color(0xfffbfbfb),
                      ),
                    )),
              ));
        })()
    ));
  }
}
