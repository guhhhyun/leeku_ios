
import 'package:egu_industry/app/pages/test/blue_tooth_controller.dart';
import 'package:get/get.dart';

class BlueToothBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlueToothController());
  }
}
