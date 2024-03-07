

import 'package:egu_industry/app/pages/gagongFacility/gagong_facility_controller.dart';
import 'package:get/get.dart';

class  GagongFacilityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GagongFacilityController());
  }
}
