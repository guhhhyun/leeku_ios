

import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_controller.dart';
import 'package:get/get.dart';

class FacilityMonitoringBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FacilityMonitoringController());
  }
}
