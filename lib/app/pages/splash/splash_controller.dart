
import 'package:egu_industry/app/common/global_service.dart';
import 'package:get/get.dart';

import '../../routes/app_route.dart';

class SplashController extends GetxController {

  GlobalService gs = Get.find();
  @override
  void onInit() {
    super.onInit();
    Get.log('SplashController- onInit');
  }

  @override
  void onClose() {
    Get.log('SplashController - onClose');
    super.onClose();
  }

  @override
  void onReady() async {
    Get.log('SplashController- onReady');
    await Future.delayed(Duration(milliseconds: 1000));
    gs.loadLoginInfo();
  }
}
