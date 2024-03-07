

import 'package:egu_industry/app/pages/packagingInspec/packaging_inspec_controller.dart';
import 'package:get/get.dart';

class PackagingInspecBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackagingInspecController());
  }
}
