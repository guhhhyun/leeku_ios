import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class MainServiceCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
          color: AppTheme.light_ui_01,
      padding: const EdgeInsets.only(
          left: AppTheme.spacing_m_16,
          right: AppTheme.spacing_m_16,
          top: AppTheme.spacing_xl_24,
       ),
      // color: AppTheme.light_ui_01,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.all(0)),
            ),
            onPressed: () {
              launchUrl(Uri(scheme: 'tel', host: '031-494-2929'));
              Get.log('TextButton 누름');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppTheme.light_ui_04, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/app/phone.png',
                    width: 14,
                  ),
                  const SizedBox(width: AppTheme.spacing_s_12),
                  Container(
                      margin: const EdgeInsets.only(
                          top: AppTheme.spacing_m_16,
                          bottom: AppTheme.spacing_m_16),
                      child: Text('고객센터 031-494-2929',
                          style: AppTheme.titleSubhead3
                              .copyWith(color: AppTheme.light_text_secondary))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppTheme.spacing_xl_24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '평    일',
                style: AppTheme.titleSubhead1
                    .copyWith(color: AppTheme.light_text_secondary),
              ),

              /// 원래 13
              const SizedBox(
                width: AppTheme.spacing_s_12,
              ),
              Text(
                '09:00 ~ 18:00',
                style: AppTheme.bodyCaption
                    .copyWith(color: AppTheme.light_text_secondary),
              ),
              const SizedBox(
                width: AppTheme.spacing_xl_24,
              ),
              Text(
                '주말, 공휴일 제외',
                style: AppTheme.bodyCaption.copyWith(
                    fontSize: 12, color: AppTheme.light_text_secondary),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
