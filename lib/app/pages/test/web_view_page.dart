
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useWideViewPort: false,
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.light_ui_background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/app/arrow2Right.svg',
            width: 24,
            height: 24,
          ),
        ),
        title: Text(
          '${widget.title}',
          style:
          AppTheme.titleHeadline.copyWith(color: AppTheme.light_text_cto),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: InAppWebView(
                      key: webViewKey,

                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                              "https://www.google.com/")),

                      initialOptions: options,
                      onWebViewCreated: (webController) {
                        // webViewController.
                        //  webController.loadData(data: reqMmsAuthUrl());


                        webViewController = webController;
                      },

                      onLoadStart: (controller, url) {},
                      onCloseWindow: (webController) {
                        Get.log('onCloseWindow !!');
                      },
                      androidOnPermissionRequest: (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading: (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        Get.log('shouldOverrideUrlLoading - uri = ${uri.toString()}');

                        return NavigationActionPolicy.ALLOW;
                      },

                    ),
                  ),
                )
              ]

          ),
        ],
      ),
    );
  }
}

