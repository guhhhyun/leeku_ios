
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomePage());
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  CommonAppbarWidget(title: '공지사항', isLogo: false, isFirstPage: true,),
                  _listArea(),
                  SliverToBoxAdapter(child: SizedBox(height: 100,))
                  //   _listArea()
                ],
              ),
              Obx(() => CommonLoading(bLoading: controller.isLoading.value))
            ],
          ),
        ),
        //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }


  Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.noticeList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {
    return Obx(() => Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: EdgeInsets.only(top: 24, bottom: 18, left: 18, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_c_gray_100.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.noticeList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.noticeList[index]['GUBUN'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(controller.noticeList[index]['TITLE'].toString(),
                    style: AppTheme.a14500
                        .copyWith(color: AppTheme.a6c6c6c), softWrap: true),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

}