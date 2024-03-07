
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:get/get.dart';

class FacilityFirstBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FacilityFirstController());
  }
}
