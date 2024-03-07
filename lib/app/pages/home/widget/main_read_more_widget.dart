import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';



class MainReadMoreWidget extends StatefulWidget {
  const MainReadMoreWidget({Key? key}) : super(key: key);

  @override
  _MainReadMoreWidgetState createState() => _MainReadMoreWidgetState();
}

class _MainReadMoreWidgetState extends State<MainReadMoreWidget> {
  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      // padding: EdgeInsets.only(top: 32, left: 16),
      padding: const EdgeInsets.only(
          left: AppTheme.spacing_m_16,
          right: AppTheme.spacing_m_16,
          bottom: AppTheme.spacing_xxl_32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const SizedBox(
            height: 10,
          ),

          const SizedBox(
            height: AppTheme.spacing_l_20,
          ),
          /// 웹쪽 이용약관 만들면 웹뷰로 띄우는 식으로 만들면될 듯
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                onPressed: () {
                  Get.log('이용 약관 클릭!');
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      host: 'www.leeku.net',
                     // path: 'front/company.do',
                     // query: 'mobileYn=Y&siteInfoCd=03'
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text('이용 약관',
                    style: AppTheme.bodyCaption
                        .copyWith(color: AppTheme.light_text_tertiary),
                    textAlign: TextAlign.left),
              ),
              const SizedBox(
                width: AppTheme.spacing_xs_8,
              ),
              Container(
                  width: 1,
                  height: 6,
                  decoration: const BoxDecoration(color: AppTheme.light_ui_06)),
              /// 웹쪽 개인정보처리방침 만들면 웹뷰로 띄우는 식으로 만들면될 듯
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                onPressed: () {
                  Get.log('개인정보처리방침 클릭!');
                 // Get.to(WebViewPage(siteInfoCd: '03', title: '이용약관'));
                  /*launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.steelshop.com',
                        path: 'front/company.do',
                        query: 'mobileYn=Y&siteInfoCd=03'),
                  //  mode: LaunchMode.externalApplication,
                  );*/
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: AppTheme.spacing_xs_8,
                    ),
                    Text('개인정보처리방침',
                        style: AppTheme.bodyCaption
                            .copyWith(color: AppTheme.black),
                        textAlign: TextAlign.left),
                    const SizedBox(
                      width: AppTheme.spacing_xs_8,
                    ),
                  ],
                ),
              ),
              Container(
                  width: 1,
                  height: 6,
                  decoration: const BoxDecoration(color: AppTheme.light_ui_06)),
              const SizedBox(
                width: AppTheme.spacing_xs_8,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                onPressed: () {
                  Get.log('사업자정보 클릭!');
                 // Get.to(WebViewPage(siteInfoCd: '21', title: '개인정보처리방침'));
                  /*launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.steelshop.com',
                        path: 'front/company.do',
                        query: 'mobileYn=Y&siteInfoCd=04'),
                    //  mode: LaunchMode.externalApplication,
                  );*/
                },
                child: Text('사업자정보',
                    style: AppTheme.bodyCaption
                        .copyWith(color: AppTheme.light_text_tertiary),
                    textAlign: TextAlign.left),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('COPYRIGHT© 2023 LEEKU INDUSTRIAL CO., LTD.',
                  style: AppTheme.bodyCaption
                      .copyWith(fontSize: 10.0, color: AppTheme.light_cancel),
                  textAlign: TextAlign.left),
              Text('ALL RIGHTS RESERVED.',
                  style: AppTheme.bodyCaption
                      .copyWith(fontSize: 10.0, color: AppTheme.light_cancel),
                  textAlign: TextAlign.left)
            ],
          ),
          const SizedBox(
            height: 46,
          )
        ],
      ),
    ));
  }

  Widget TextWidget(String text) {
    return Text(
      text,
      style: AppTheme.bodyCaption.copyWith(color: AppTheme.light_cancel),
    );
  }

  void _trueChange() {
    setState(() {
      _isShow = true;
    });
  }

  void _falseChange() {
    setState(() {
      _isShow = false;
    });
  }
}
