import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class BottomSheetModal extends StatelessWidget {
  BottomSheetModal({Key? key}) : super(key: key);
  ScrapLabelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))
      ),
      padding: EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
      height: 500,
      child: CustomScrollView(
        slivers: [
          _title(),
          Obx(() =>  _calendar2(context)),
          Obx(() =>   controller.popUpDataList.isNotEmpty ?
          _listArea() : SliverToBoxAdapter(child: Container()))
          // _bottom(context)
        ],
      ),
    );
  }



  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.only(left: 12, bottom: 20),
          child: Text('계량정보 선택', style: AppTheme.titleHeadline.copyWith(color: AppTheme.black),
          )),
    );
  }


  Widget _calendar2(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( color: AppTheme.ae2e2e2),
                  color: AppTheme.white,
                ),
                child: InkWell(
                  onTap: () async{
                    var datePicked = await DatePicker.showSimpleDatePicker(
                      titleText: '날짜 선택',
                      itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                      context,
                      confirmText: '확인',
                      cancelText: '취소',
                      textColor: AppTheme.black,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2060),
                      dateFormat: "yyyy-MM-dd",
                      locale: DateTimePickerLocale.ko,
                      looping: true,
                    );
                    if(datePicked != null) {
                      int startIndex = datePicked.toString().indexOf(' ');
                      int lastIndex = datePicked.toString().length;
                      controller.startValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                      controller.popUpDataList.clear();
                      HomeApi.to.PROC('USP_SCS0300_R01', {'p_WORK_TYPE':'Q_SCALE2', '@p_DATE_FROM':'${controller.startValue.value.replaceAll('-', '')}','@p_DATE_TO':'${controller.endValue.value.replaceAll('-', '')}'}).then((value) =>
                        {
                          Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                          if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                            for(var i = 0; i <  value['RESULT']['DATAS'][0]['DATAS'].length; i++){
                              controller.popUpDataList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                            },
                          },
                          Get.log('datasList: ${controller.popUpDataList}'),
                        });
                    }else {
                      controller.startValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    }
                    if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                      controller.startValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all( color: AppTheme.ae2e2e2)),
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.startValue.value, style: AppTheme.a12500
                            .copyWith(color: AppTheme.a6c6c6c
                            , fontSize: 17),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            SizedBox(height: 50, width: 15, child: Center(
              child: Text('~',style: AppTheme.a14500
                  .copyWith(color: AppTheme.black)),
            ),),
            const SizedBox(width: 12,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all( color: AppTheme.ae2e2e2),
                  color: AppTheme.white,
                ),
                child: InkWell(
                  onTap: () async{
                    var datePicked = await DatePicker.showSimpleDatePicker(
                      titleText: '날짜 선택',
                      itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                      context,
                      confirmText: '확인',
                      cancelText: '취소',
                      textColor: AppTheme.black,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2060),
                      dateFormat: "yyyy-MM-dd",
                      locale: DateTimePickerLocale.ko,
                      looping: true,
                    );
                    if(datePicked != null) {
                      int startIndex = datePicked.toString().indexOf(' ');
                      int lastIndex = datePicked.toString().length;
                      controller.endValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');

                      controller.popUpDataList.clear();
                        HomeApi.to.PROC('USP_SCS0300_R01', {'p_WORK_TYPE':'Q_SCALE2', '@p_DATE_FROM': controller.startValue.value.replaceAll('-', ''),'@p_DATE_TO': controller.endValue.value.replaceAll('-', '')}).then((value) =>
                        {
                          Get.log('value[DATAS]: ${value['RESULT']['DATAS'][0]['DATAS']}'),
                          if(value['RESULT']['DATAS'][0]['DATAS'] != null) {
                            for(var i = 0; i < value['RESULT']['DATAS'][0]['DATAS'].length; i++){
                              controller.popUpDataList.add(value['RESULT']['DATAS'][0]['DATAS'][i]),
                            },
                          },
                          Get.log('datasList: ${controller.popUpDataList}'),
                        });

                    }else {
                      controller.startValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    }
                    if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                      controller.endValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    }

                    Get.log("Date Picked ${datePicked.toString()}");
                    //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.ae2e2e2)),
                    width: 150,
                    padding: const EdgeInsets.only( right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.endValue.value, style: AppTheme.a14500
                            .copyWith(color: AppTheme.a6c6c6c
                            , fontSize: 17),),
                      ],
                    ),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          controller.selectedPopList.add(false);
          return _listItem(index: index, context: context);
        }, childCount: controller.popUpDataList.length));
  }

    Widget _listItem({required BuildContext context, required int index}) {


      //  var regDttmFirstIndex =
      //  controller.noticeList[index].regDttm.toString().lastIndexOf(' ');

      return Obx(() => TextButton(
        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5)))),
            /*backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.light_primary,
              ),*/
            padding:
            MaterialStateProperty.all(const EdgeInsets.all(0))),
        onPressed: () {
          if(controller.selectedPopList[index] == true) {
            controller.selectedPopList[index] = false;
            controller.isChoiceSheet.value = false;
            controller.selectedContainer.clear();
          }else {
            for(var i = 0; i < controller.selectedPopList.length; i++) {
              controller.selectedPopList[i] = false;
            }
            controller.selectedContainer.clear();
            controller.selectedPopList[index] = true;
            if(controller.selectedPopList[index] == true) {
              controller.isChoiceSheet.value = true;

              controller.selectedContainer.add(controller.popUpDataList[index]);
            /*  controller.measList[0]['CAR_NO'] = controller.selectedContainer[0]['CAR_NO'];
              controller.measList[0]['CUST_NM'] = controller.selectedContainer[0]['NAME'];
              controller.weighingInfoTextController.text = controller.selectedContainer[0]['CODE'];*/
              controller.weighingInfoTextController.text = controller.selectedContainer[0]['CODE'];
            }
          }
          Get.back();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 12),
                  padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                      border: controller.selectedPopList[index] == true ? Border.all(color: AppTheme.black, width: 2) : Border.all(color: AppTheme.gray_c_gray_200),
                      borderRadius: BorderRadius.circular(10),
                    color: AppTheme.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CODE', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                          Text('${controller.popUpDataList[index]['CODE']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('차량번호:', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              SizedBox(width: 4,),
                              Text('${controller.popUpDataList[index]['CAR_NO']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('품명: ', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                              SizedBox(width: 4,),
                              Text('${controller.popUpDataList[index]['ITEM_NM']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('거래처명', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                          Text(' ${controller.popUpDataList[index]['NAME']}', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                        ],
                      ),


                    ],
                  ),
                )
            ),
          ],
        ),
      ),

      );
    }
}
