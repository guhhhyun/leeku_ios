
import 'package:egu_industry/app/pages/setting/setting_controller.dart';
import 'package:get/get.dart';


class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
