import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/app_theme.dart';
import '../../common/common_bottom_sheet.dart';
import '../../common/global_service.dart';
import '../../routes/app_route.dart';
import '../home/home_page.dart';
import '../setting/setting_page.dart';
import 'main_controller.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return MainPage();
  }
}

enum EnumMainPageType { HOME_PAGE, CATEGORY_PAGE, TEST_PAGE, MY_PAGE }

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  MainController controller = Get.find();

  GlobalService gs = Get.find();

  void logOutDialog(BuildContext context) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Container(
            child: CupertinoAlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/app/cancel_warning.png",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Text(
                      '로그아웃 하시겠습니까?',
                      style: AppTheme.notosans600.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      "취소",
                      style: AppTheme.notosans500
                          .copyWith(fontSize: 14, color: AppTheme.txt),
                    ),
                    onPressed: () {
                      Get.back();
                    }),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      "로그아웃",
                      style: AppTheme.notosans500
                          .copyWith(fontSize: 14, color: AppTheme.dk_red),
                    ),
                    onPressed: () {
                      //GlobalService.to.logout();
                      Get.back();
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: controller.selected.value == 0 ? null : AppBar(
          backgroundColor: Colors.white,
          title: Text(controller.appBarTitle.value),
          centerTitle: true,
          elevation: 0.0,
        ),
        endDrawer: const Drawer(
          child: Text('asd'),
        ),
        backgroundColor: Colors.white,
        body: Obx(() {
          switch (controller.selected.value) {
            case 0:
              return HomePage();
           /* case 1:
              return BluetoothPage();
            case 2:
              return SettingPage();*/
            default:
              return HomePage();
          }
        })));
       // bottomNavigationBar: CommonBottomWidget()));
  }
}
