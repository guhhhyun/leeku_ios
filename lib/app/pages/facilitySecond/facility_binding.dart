
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:get/get.dart';

class FacilityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FacilityController());
  }
}