

import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_controller.dart';
import 'package:get/get.dart';

class ScrapLabelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScrapLabelController());
  }
}
