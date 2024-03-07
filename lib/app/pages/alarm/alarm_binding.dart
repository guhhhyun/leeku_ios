
import 'package:egu_industry/app/pages/alarm/alarm_controller.dart';
import 'package:get/get.dart';


class AlarmBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmController());
  }
}
