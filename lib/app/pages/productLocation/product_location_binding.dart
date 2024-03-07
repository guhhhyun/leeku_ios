

import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:get/get.dart';

class ProductLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductLocationController());
  }
}
