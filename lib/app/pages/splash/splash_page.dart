
import 'package:egu_industry/app/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/app_theme.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Center(child: Image.asset('assets/app/egu.png', width: 50, height: 50,)),
                     SizedBox(height: 4,),
                     Center(
                       child: SizedBox(
                            //width : 100,
                            height: 75,
                            child: Text(
                              "이구산업",
                              style: AppTheme.notosans600
                                  .copyWith(color: AppTheme.dongkuk_blue, fontSize: 30),
                            ),),
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
