

import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:get/get.dart';

class NoticeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
