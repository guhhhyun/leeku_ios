import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/pages/test/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/test/web_view_page.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class BluetoothPage extends StatelessWidget {
  BluetoothPage({Key? key}) : super(key: key);

  BlueToothController controller = Get.find();
  HomeController controller2 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonAppbarWidget(title: '설비/안전 조회 및 등록', isLogo: false, isFirstPage: true )
        ],
      ),

    );
  }
}
