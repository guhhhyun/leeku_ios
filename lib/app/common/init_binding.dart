
import 'package:get/get.dart';

import '../net/home_api.dart';
import 'global_service.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.log('InitBinding start');
    Get.put(HomeApi());
    Get.put(GlobalService());
    Get.log('InitBinding end');
  }
}
