

import 'package:egu_industry/app/pages/processTransfer/process_transfer_controller.dart';
import 'package:get/get.dart';

class ProcessTransferBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProcessTransferController());
  }
}
