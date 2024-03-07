import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/pages/processTransfer/process_transfer_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonBackDialogWidget extends StatelessWidget {
  int pageFlag;

  CommonBackDialogWidget(
      {super.key,

        required this.pageFlag
      });

  Widget _contentText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '저장되지 않은 내역이 있을 수 있습니다.',
              style: AppTheme.bodyBody2,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
            Text(
              '계속하시겠습니까?',
              style: AppTheme.bodyBody2,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
          ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      scrollable: true,
      content: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '저장되지 않은 내역이 있을 수 있습니다.',
              style: AppTheme.bodyBody2,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
            Text(
              '계속하시겠습니까?',
              style: AppTheme.bodyBody2,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
          ],
        ),
      ),
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 16, bottom: 12),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5)))),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                // 성공
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  color: AppTheme.light_cancel,
                  child: Center(
                      child: Text(
                          '취소',
                          style: AppTheme.titleSubhead2.copyWith(color: AppTheme.white)
                      )),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5)))),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                // 성공
                onPressed: () {
                  pageFlag == 1 ?
                  Get.toNamed(Routes.FACILITY_FIRST)
                      :  Get.offAllNamed(Routes.FACILITY);
                  //  Get.back();
                  //  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  color: Colors.black,
                  child: Center(
                      child: Text(
                          '확인',
                          style: AppTheme.titleSubhead2.copyWith(color: AppTheme.white)
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
