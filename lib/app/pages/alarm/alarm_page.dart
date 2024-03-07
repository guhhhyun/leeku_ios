import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/alarm/alarm_controller.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AlarmPage extends GetView<AlarmController> {
  AlarmPage({Key? key}) : super(key: key);
  GlobalService gs = Get.find();

  Widget _title() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.light_ui_background,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          Get.offAll(HomePage());
        },
        icon: SvgPicture.asset(
          'assets/app/arrow2Left.svg',
        ),
      ),
      title: Text(
        '알림',
        style: AppTheme.a18700.copyWith(color: AppTheme.black),
      ),
      centerTitle: false,
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          color: AppTheme.dark_text_secondary,
          height: 1,
        ),
        Column(children: [
          Obx(() => controller.isLoading.value == false ? TabBar(
                    onTap: (i) async {
                      if (i == 0) {
                        controller.chkYn.value = '';
                        await controller.reqListAlarm();
                      } else if (i == 1) {
                        controller.chkYn.value = 'N';
                        await controller.reqListAlarm();
                      } else if (i == 2) {
                        controller.chkYn.value = 'Y';
                        await controller.reqListAlarm();
                      }
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: controller.tabController,
                    indicatorColor: AppTheme.black,
                    labelColor: AppTheme.black,
                    unselectedLabelColor: AppTheme.light_ui_05,
                    tabs: [
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text(
                          '전체',
                          style: AppTheme.titleSubhead3,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text(
                          '미확인',
                          style: AppTheme.titleSubhead3,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text(
                          '확인',
                          style: AppTheme.titleSubhead3,
                        ),
                      ),
                    ],
                  )
                 : Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '전체',
                    style: AppTheme.titleSubhead3.copyWith(color: AppTheme.light_ui_05),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '미확인',
                    style: AppTheme.titleSubhead3.copyWith(color: AppTheme.light_ui_05),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '확인',
                    style: AppTheme.titleSubhead3.copyWith(color: AppTheme.light_ui_05),
                  ),
                ),
              ),
            ],
          )),
          Container(
            color: AppTheme.dark_text_secondary,
            height: 1,
          ),
          SizedBox(height: 12,),
          Obx(() => SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child:TabBarView(
              physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  controller.isLoading.value == true ? CommonLoading(bLoading: controller.isLoading.value) :
                  _allBody(),
                  controller.isLoading.value == true ? CommonLoading(bLoading: controller.isLoading.value) :
                  _noConfirmBody(),
                  controller.isLoading.value == true ? CommonLoading(bLoading: controller.isLoading.value) :
                  _confirmBody()
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _allBody() {
    return RefreshIndicator(
        onRefresh: () async {
          controller.chkYn.value = '';
          await controller.reqListAlarm();
          return Future.value(true);
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            Obx(() =>
                _allListArea()
            )
          ]),
        ]));
  }


  Widget _allListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _allListItem(index: index, context: context);
        }, childCount: controller.alarmAllList.length));
  }

  Widget _allListItem({required BuildContext context, required int index}) {
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
          controller.alarmAllList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(controller.alarmAllList[index]['TYPE_MSG_NM'] != null ? '[${controller.alarmAllList[index]['TYPE_MSG_NM']}] ' : '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                  Text(controller.alarmAllList[index]['TEXT_TG'] ?? '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                ],
              ),
              Container(
                width: 160,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text('알림: ', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                      Text(controller.alarmAllList[index]['ACT_DTM'] != null ? '${controller.alarmAllList[index]['ACT_DTM'].toString().substring(0, 10)} ${controller.alarmAllList[index]['ACT_DTM'].toString().substring(11, 16)}' : '',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.black)),
                    ],
                  ),
                ),
              ),
            ],
          )
              : Container(),
          SizedBox(height: 8,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.alarmAllList[index]['TEXT_CT'] ?? '',
                        style: AppTheme.a16500),
                  SizedBox(height: 4,),
                  controller.alarmAllList.isNotEmpty ?
                 Row(
                        children: [
                          Text('의뢰: ',
                              style: AppTheme.a15500
                                  .copyWith(color: AppTheme.a6c6c6c)),
                          Text(controller.alarmAllList[index]['REQ_USER_NM'] ?? '',
                              style: AppTheme.a14500
                                  .copyWith(color: AppTheme.black)),
                          SizedBox(width: 10,),
                          Text('담당: ',
                              style: AppTheme.a14500
                                  .copyWith(color: AppTheme.a6c6c6c)),
                          Text(controller.alarmAllList[index]['WRK_DEPT_NM'] ?? '',
                              style: AppTheme.a14500
                                  .copyWith(color: AppTheme.black)),
                        ],
                      ) : Container(),
                ],
              ),
              InkWell(
                onTap:  controller.isAlarmList[index] == 'Y' ? null : () async {
                  var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"U_CHK","@p_RCV_USER":Utils.getStorage.read('userId'),"@p_ID":controller.alarmAllList[index]["ID"]}).then((value) =>
                  {
                    controller.chkDtmNew.value = value['RESULT']['DATAS'][0]['DATAS'][0]['CHK_DTM'],
                  });
                  controller.alarmAllList[index]["CHK_YN"] = 'Y';
                  controller.isAlarmList[index] = 'Y';
                  controller.alarmAllList[index]["CHK_DTM"] = controller.chkDtmNew.value;
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: controller.isAlarmList[index] == 'Y' ? AppTheme.blue_blue_200 : AppTheme.red_red_400
                  ),

                  child: Center(child: Text( controller.isAlarmList[index] == 'Y' ?
                      '${controller.alarmAllList[index]['CHK_DTM'].toString().substring(0, 10)} ${controller.alarmAllList[index]['CHK_DTM'].toString().substring(11, 16)}': '알림 미확인', style: AppTheme.a14700.copyWith(color: AppTheme.white),)),
                ),
              )


            ],
          ),
          SizedBox(height: 4,),
        ],
      ),
    ),
    );





    /*Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: const BoxDecoration(
                border:
                Border(bottom: BorderSide(color: AppTheme.gray_gray_200))),
            padding: const EdgeInsets.only(
                top: AppTheme.spacing_s_12, bottom: AppTheme.spacing_s_12),
            child: Theme(
              data:
              Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('제목 ${index + 1}', style: AppTheme.a18700.copyWith(color: AppTheme.red_red_800),)
                        ],
                      )
                    ],
                  ),

                  //   initiallyExpanded: true,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: AppTheme.light_ui_01,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: AppTheme.spacing_m_16,
                              top: AppTheme.spacing_xl_24,
                              right: AppTheme.spacing_m_16,
                              bottom: AppTheme.spacing_xl_24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('장애일시: 2023-08-31 00:00', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                    Text('경과시간: ${index + 1}h', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                  ],
                                ),
                                const SizedBox(height: 12,),
                                Text('등록자: 강구현${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                const SizedBox(height: 12,),
                                Text('장애내용: 설비 장애 코드 ${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
      ],
    );*/
  }

  Widget _noConfirmBody() {
    return RefreshIndicator(
        onRefresh: () async {
          controller.chkYn.value = 'N';
          await controller.reqListAlarm();
          return Future.value(true);
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            Obx(()=>  _noConformListArea())
          ]),
        ]));
  }

  Widget _noConformListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _noConfirmListItem(index: index, context: context);
        }, childCount: controller.alarmNList.length));
  }

  Widget _noConfirmListItem({required BuildContext context, required int index}) {
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
          controller.alarmNList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(controller.alarmNList[index]['TYPE_MSG_NM'] != null ? '[${controller.alarmNList[index]['TYPE_MSG_NM']}] ' : '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                  Text(controller.alarmNList[index]['TEXT_TG'] != null ? controller.alarmNList[index]['TEXT_TG'] : '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                ],
              ),
              Row(
                children: [
                  Text('알림: ', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  Text(controller.alarmNList[index]['ACT_DTM'] != null ? '${controller.alarmNList[index]['ACT_DTM'].toString().substring(0, 10)} ${controller.alarmNList[index]['ACT_DTM'].toString().substring(11, 16)}' : '',
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black)),
                ],
              ),
            ],
          )
              : Container(),
          SizedBox(height: 8,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.alarmNList[index]['TEXT_CT'] ?? '',
                      style: AppTheme.a16500),
                  SizedBox(height: 4,),
                  controller.alarmNList.isNotEmpty ?
                  Row(
                    children: [
                      Text('의뢰: ',
                          style: AppTheme.a15500
                              .copyWith(color: AppTheme.a6c6c6c)),
                      Text(controller.alarmNList[index]['REQ_USER_NM'] ?? '',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.black)),
                      SizedBox(width: 10,),
                      Text('담당: ',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.a6c6c6c)),
                      Text(controller.alarmNList[index]['WRK_DEPT_NM'] ?? '',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.black)),
                    ],
                  ) : Container(),
                ],
              ),
              InkWell(
                onTap:  controller.isAlarmList[index] == 'Y' ? null : () async {
                  var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"U_CHK","@p_RCV_USER":Utils.getStorage.read('userId'),"@p_ID":controller.alarmNList[index]["ID"]}).then((value) =>
                  {
                    controller.chkDtmNew.value = value['RESULT']['DATAS'][0]['DATAS'][0]['CHK_DTM'],
                  });
                  controller.alarmNList[index]["CHK_YN"] = 'Y';
                  controller.isAlarmList[index] = 'Y';
                  controller.alarmNList[index]["CHK_DTM"] = controller.chkDtmNew.value;
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.isAlarmList[index] == 'Y' ? AppTheme.blue_blue_200 : AppTheme.red_red_400
                  ),

                  child: Center(child: Text( controller.isAlarmList[index] == 'Y' ?
                  '${controller.alarmNList[index]['CHK_DTM'].toString().substring(0, 10)} ${controller.alarmNList[index]['CHK_DTM'].toString().substring(11, 16)}': '알림 미확인', style: AppTheme.a14700.copyWith(color: AppTheme.white),)),
                ),
              )


            ],
          ),
          SizedBox(height: 4,),
        ],
      ),
    ),
    );
  }


  Widget _confirmBody() {
    return RefreshIndicator(
        onRefresh: () async {
          controller.chkYn.value = 'Y';
          await controller.reqListAlarm();
          return Future.value(true);
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            Obx(() =>  _conformListArea())
          ])
        ]));
  }

  Widget _conformListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _confirmListItem(index: index, context: context);
        }, childCount: controller.alarmYList.length));
  }

  Widget _confirmListItem({required BuildContext context, required int index}) {
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
          controller.alarmYList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(controller.alarmYList[index]['TYPE_MSG_NM'] != null ? '[${controller.alarmYList[index]['TYPE_MSG_NM']}] ' : '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                  Text(controller.alarmYList[index]['TEXT_TG'] != null ? controller.alarmYList[index]['TEXT_TG'] : '',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                ],
              ),
              Row(
                children: [
                  Text('알림: ', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  Text(controller.alarmYList[index]['ACT_DTM'] != null ? '${controller.alarmYList[index]['ACT_DTM'].toString().substring(0, 10)} ${controller.alarmYList[index]['ACT_DTM'].toString().substring(11, 16)}' : '',
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black)),
                ],
              ),
            ],
          )
              : Container(),
          SizedBox(height: 8,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.alarmYList[index]['TEXT_CT'] ?? '',
                      style: AppTheme.a16500),
                  SizedBox(height: 4,),
                  controller.alarmYList.isNotEmpty ?
                  Row(
                    children: [
                      Text('의뢰: ',
                          style: AppTheme.a15500
                              .copyWith(color: AppTheme.a6c6c6c)),
                      Text(controller.alarmYList[index]['REQ_USER_NM'] ?? '',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.black)),
                      SizedBox(width: 10,),
                      Text('담당: ',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.a6c6c6c)),
                      Text(controller.alarmYList[index]['WRK_DEPT_NM'] ?? '',
                          style: AppTheme.a14500
                              .copyWith(color: AppTheme.black)),
                    ],
                  ) : Container(),
                ],
              ),
              InkWell(
                onTap:  controller.isAlarmList[index] == 'Y' ? null : () async {
                  var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"U_CHK","@p_RCV_USER":Utils.getStorage.read('userId'),"@p_ID":controller.alarmYList[index]["ID"]}).then((value) =>
                  {
                    controller.chkDtmNew.value = value['RESULT']['DATAS'][0]['DATAS'][0]['CHK_DTM'],
                  });
                  controller.alarmYList[index]["CHK_YN"] = 'Y';
                  controller.isAlarmList[index] = 'Y';
                  controller.alarmYList[index]["CHK_DTM"] = controller.chkDtmNew.value;
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.isAlarmList[index] == 'Y' ? AppTheme.blue_blue_200 : AppTheme.red_red_400
                  ),

                  child: Center(child: Text( controller.isAlarmList[index] == 'Y' ?
                  '${controller.alarmYList[index]['CHK_DTM'].toString().substring(0, 10)} ${controller.alarmYList[index]['CHK_DTM'].toString().substring(11, 16)}': '알림 미확인', style: AppTheme.a14700.copyWith(color: AppTheme.white),)),
                ),
              )


            ],
          ),
          SizedBox(height: 4,),
        ],
      ),
    ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomePage());
        return Future(() => true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [_title(), _body(context)],
          ),
        ),
      ),
    );
  }
}
