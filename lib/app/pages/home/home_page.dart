

import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/home/widget/home_news_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_icon_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_read_more_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_slide_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../common/app_theme.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.find();
  GlobalService gs = Get.find();

  // 퇴사자 여부 판단
  void userLeft() async {
    String status = await HomeApi.to.LOGIN_MOB(Utils.getStorage.read('userId'), Utils.getStorage.read('userPw'));
    Get.log('로그인~~~~~~~~~~~~~~~~~~~~ $status');
    status == 'SUCCESS' ? null : gs.logout();
  }

  @override
  Widget build(BuildContext context) {
    userLeft();
    return  Obx(() => Material(
        color: AppTheme.white,
        child: gs.loginId.value != '' ? CustomScrollView(
          slivers: [
            //MainHeader(),
            MainSlideWidget(),
            MainIconWidget(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            HomeNewsWidget(),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppTheme.spacing_xxxl_40),
            ),
            //  MainReadMoreWidget()
          ],
        ) : Container(
          color: AppTheme.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('로그인이 필요한 서비스 입니다.', style: AppTheme.a18700.copyWith(color: AppTheme.black),),
              const SizedBox(height: 12,),
              Text('로그인 해주세요', style: AppTheme.a18700.copyWith(color: AppTheme.black),),
              const SizedBox(height: 12,),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.LOGIN_PAGE);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  color: AppTheme.blue_blue_200,
                  child: Text('로그인', style: AppTheme.a16700.copyWith(color: AppTheme.black),),
                ),
              )
            ],
          ),
        )
    ));
  }
}
