

import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_controller.dart';
import 'package:get/get.dart';

class InventoryCountingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InventoryCountingController());
  }
}
