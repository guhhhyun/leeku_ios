

import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';
import 'package:get/get.dart';

class InventoryCheckBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InventoryCheckController());
  }
}
