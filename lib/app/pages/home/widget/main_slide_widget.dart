import 'package:carousel_slider/carousel_slider.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/print/bluetooth_printer.dart';
import 'package:egu_industry/app/print/pos_printer.dart';
import 'package:egu_industry/app/print/print_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:egu_industry/app/routes/app_route.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class MainSlideWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainSlideWidgetSate();
}

class _MainSlideWidgetSate extends State<MainSlideWidget> {

  int mainSlideIndex = 0;

  Widget _sliderContainer(String imgUrl) {
    return Container(
      child: Image.asset(imgUrl,
          width: double.infinity, height: 294, fit: BoxFit.cover),
    );
  }

  Widget _btnSliderContainer(
      {required String imgUrl, required Function() onpress}) {
    return Material(
      child: InkWell(
        onTap: onpress,
        child: Ink.image(
          image: AssetImage(
            imgUrl,
          ),
          height: 294,
          fit: BoxFit.cover,
        ),

        // child: Container(
        //   child: Image.asset(imgUrl,
        //       width: double.infinity, height: 294, fit: BoxFit.cover),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent)
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,

          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    mainSlideIndex = index;
                  });
                },
                // enlargeCenterPage: false,
              ),
              items: [
                Stack(
                  children: [
                    _sliderContainer('assets/app/Group_225.png'),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('단동', style: AppTheme.newTitleDisplay.copyWith(color: AppTheme.white),),
                          Text('Red Brass', style: AppTheme.a24400.copyWith(color: AppTheme.white),),
                          SizedBox(height: 14,),
                          Text('단동 1종 ~ 3종', style: AppTheme.a16400.copyWith(color: AppTheme.white),)
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _sliderContainer('assets/app/Group_227.png'),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('동', style: AppTheme.newTitleDisplay.copyWith(color: AppTheme.white),),
                          Text('Copper', style: AppTheme.a24400.copyWith(color: AppTheme.white),),
                          SizedBox(height: 14,),
                          Text('타프피치동/일산탈동/무산소동', style: AppTheme.a16400.copyWith(color: AppTheme.white),)
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _sliderContainer('assets/app/Group_228.png'),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('황동', style: AppTheme.newTitleDisplay.copyWith(color: AppTheme.white),),
                          Text('Brass', style: AppTheme.a24400.copyWith(color: AppTheme.white),),
                          SizedBox(height: 14,),
                          Text('황동 1종 ~ 3종', style: AppTheme.a16400.copyWith(color: AppTheme.white),)
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _sliderContainer('assets/app/Group_226.png'),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('인청동', style: AppTheme.newTitleDisplay.copyWith(color: AppTheme.white),),
                          Text('Phodphor Bronze', style: AppTheme.a24400.copyWith(color: AppTheme.white),),
                          SizedBox(height: 14,),
                          Text('인청동 1종 ~ 3종', style: AppTheme.a16400.copyWith(color: AppTheme.white),)
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _sliderContainer('assets/app/Group_229.png'),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('기타합급', style: AppTheme.newTitleDisplay.copyWith(color: AppTheme.white),),
                          Text('Alloy', style: AppTheme.a24400.copyWith(color: AppTheme.white),),
                          SizedBox(height: 14,),
                          Text('C194/LFC/주석동/C4250', style: AppTheme.a16400.copyWith(color: AppTheme.white),),
                          Text('뇌관용동/네이벌 황동', style: AppTheme.a16400.copyWith(color: AppTheme.white),)
                        ],
                      ),
                    ),
                  ],
                ),
                /*_btnSliderContainer(
                  imgUrl: 'assets/app/slide02.png',
                  onpress: () => Get.to(const BarIntroPage(),
                      transition: Transition.downToUp),
                ),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide03.png',
                    onpress: () => Get.to(const SectionIntroPage(),
                        transition: Transition.downToUp)),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide04.png',
                    onpress: () => Get.to(const PlateIntroPage(),
                        transition: Transition.downToUp)),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide05.png',
                    onpress: () => Get.to(const ColdIntroPage(),
                        transition: Transition.downToUp)),*/
              ],
            ),
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 35,),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  print('클릭');
                                  Get.to(BlePrinter());
                                },
                                child: Image.asset('assets/app/Vector.png', color: AppTheme.white, width: 30, height: 30,)
                            ),
                            SizedBox(width: 14,),
                            InkWell(
                              onTap: () async{
                                print('클릭');
                                Get.to(BluetoothPrinter());

                              },
                                child: Image.asset('assets/app/printer.png', color: AppTheme.white, width: 30, height: 30,)
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),


                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // height: 20,
                              padding: const EdgeInsets.only(
                                  left: AppTheme.spacing_m_16,
                                  right: AppTheme.spacing_m_16,
                                  bottom: AppTheme.spacing_m_16),
                              child: Container(
                                width: 50,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black45
                                ),
                                child: Center(child: Text('${mainSlideIndex + 1} / 5', style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),)),
                              )
                          )/*StepProgressIndicator(
                            totalSteps: 5,
                            padding: 0,
                            size: 2,
                            currentStep: mainSlideIndex + 1,
                            selectedColor: AppTheme.light_ui_01,
                            unselectedColor: AppTheme.light_ui_07,
                          )
                      ),*/
                        ],
                      ),
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        height: 36,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
