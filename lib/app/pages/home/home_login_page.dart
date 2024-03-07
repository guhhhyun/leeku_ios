



import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLoginPage extends StatelessWidget {
  const HomeLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('로그인이 필요한 서비스 입니다.', style: AppTheme.a18700.copyWith(color: AppTheme.black),),
          SizedBox(height: 12,),
          Text('로그인 해주세요', style: AppTheme.a18700.copyWith(color: AppTheme.black),),
          SizedBox(height: 12,),
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
    );
  }
}
