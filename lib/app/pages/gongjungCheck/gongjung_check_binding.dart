

import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_controller.dart';
import 'package:get/get.dart';

class GongjungCheckBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GongjungCheckController());
  }
}
