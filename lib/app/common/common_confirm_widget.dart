import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_theme.dart';

class CommonConfirmWidget extends StatelessWidget {
  String title;
  String? contentText;
  Widget? contentWidget;

  Function()? onOk;
  Function()? onCancel;
  Function()? onConfirm;

  CommonConfirmWidget(
      {super.key,
      required this.title,
      this.contentText,
      this.contentWidget,
      this.onOk,
      this.onCancel,
      this.onConfirm});

  Widget _contentText(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          contentText ?? '',
          style:
              AppTheme.notosans400.copyWith(color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      scrollable: true,
      title: Column(
        children: [
          const SizedBox(
            height: AppTheme.spacing_xl_24,
          ),
          Text(
            title,
            style: AppTheme.notosans600.copyWith(color: Colors.black),

            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      content: contentWidget == null ? _contentText(context) : contentWidget,
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.only(
          left: 16, right: 16),
      titlePadding: const EdgeInsets.all(0),
      contentTextStyle: AppTheme.notosans500.copyWith(color: Colors.black),
      actions: [
        onConfirm != null
            ? TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)))),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppTheme.border_light,
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(0))),
                // 성공
                onPressed: onConfirm,
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    top: AppTheme.spacing_l_20,
                    bottom: AppTheme.spacing_l_20,
                  ),
                  child: const Center(
                      child: Text(
                    '바로가기',
                    style: AppTheme.notosans500
                  )),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5)))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.border_light,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0))),

                      // 취소
                      onPressed: () {
                        Get.back();
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Center(
                            child: Text('취소',
                                style: AppTheme.notosans500.copyWith(
                                    color: AppTheme.dk_red))),
                      ),
                    ),
                  ),
                  SizedBox(width: 14,),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5)))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.border_light,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0))),
                      // 성공
                      onPressed: onOk,
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          top: AppTheme.spacing_l_20,
                          bottom: AppTheme.spacing_l_20,
                        ),
                        child: Center(
                            child: Text(
                          '확인',
                          style: AppTheme.notosans500

                        )),
                      ),
                    ),
                  )
                ],
              )
      ],
    );
  }
}
