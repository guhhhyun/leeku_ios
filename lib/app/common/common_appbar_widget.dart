
import 'package:egu_industry/app/common/back_dialog_widget.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../routes/app_route.dart';
import 'app_theme.dart';

class CommonAppbarWidget extends StatelessWidget {
  HomeController controller = Get.find();
  String title;
  Widget? titleWidget;
  bool isLogo;
  bool isFirstPage;
  bool? facilityFlag;

  PreferredSizeWidget? bottom;

  CommonAppbarWidget(
      {Key? key,
      required this.title,
      required this.isLogo,
      this.titleWidget,
      this.bottom,
      this.facilityFlag,
      required this.isFirstPage
      })
      : super(key: key);

  Widget _homeIcon() {
    return IconButton(
      onPressed: () {
        Get.offAllNamed(Routes.MAIN);
      },
      icon: const Icon(Icons.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      leading: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        ),
        onPressed: () {
          isFirstPage ?
          {Get.offAll(HomePage()), controller.reqNoticeList(), controller.reqListAlarm(),  }
              : facilityFlag == true ? _onBackKey(context, 1,) :  _onBackKey(context, 2,);
        },
        child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
      ),
      centerTitle: false,
      title: titleWidget ??
              Text(
                title,
                style: AppTheme.a18700.copyWith(color: Colors.black),
              ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      floating: true,

      expandedHeight: 30.0,
      //bottom: bottom,
    );
  }



  Future<bool> _onBackKey(BuildContext context, int pageFlag) async{
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
                              pageFlag == 1 ?
                              Get.offAllNamed(Routes.FACILITY_FIRST) : Get.offAllNamed(Routes.FACILITY);
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

}
