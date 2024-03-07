

import 'package:egu_industry/app/pages/processCheck/process_check_controller.dart';
import 'package:get/get.dart';

class ProcessCheckBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProcessCheckController());
  }
}
