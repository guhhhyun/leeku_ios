import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ModalPartListWidget extends StatelessWidget {
  ModalPartListWidget({Key? key}) : super(key: key);
  FacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
        color: AppTheme.white,
      ),

      padding: EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
      height: 700,
      child: CustomScrollView(
        slivers: [
          _title(),
          controller.partList.isNotEmpty ?
          _listArea() :
              SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Text('해당 설비의 부품이 없습니다', style: AppTheme.a18700.copyWith(color: AppTheme.black),)
                    ],
                  )
              )
        ],
      ),
    );
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.only(left: 12, bottom: 18),
          child: Text('사용부품 추가', style: AppTheme.a18700.copyWith(color: AppTheme.black),
          )),
    );
  }

  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.partList.length));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Obx(() => Column(
      children: [
        TextButton(
          onPressed: () {
            controller.isPartSelectedList[index] == false ? controller.isPartSelectedList[index] = true
                : controller.isPartSelectedList[index] = false;
            controller.isPartSelectedList[index] == true
                ? controller.partSelectedList.add(controller.partList[index])
                : controller.partSelectedList.remove(controller.partList[index]);
            controller.isPartSelectedList[index] == true
                ? controller.partSelectedQtyList.add(controller.partQtyList[index])
                : controller.partSelectedQtyList.remove(controller.partQtyList[index]);
            Get.log('${controller.partSelectedQtyList}');
          },
          child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius:10,
                      spreadRadius: 3.0,
                      offset: const Offset(0,0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.ae2e2e2)),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 12, left: 19, top: 22, bottom: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                     controller.isPartSelectedList[index] == false ?
                      Icon(Icons.check_circle, color: AppTheme.gray_c_gray_300)  : Icon(Icons.check_circle, color: AppTheme.black),
                    ],
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                                children: [
                                  Text('${controller.partList[index]['ITEM_NAME']}', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                                  SizedBox(width: 12,),
                                  Text('|'),
                                  SizedBox(width: 12,),
                                  Text('${controller.partList[index]['ITEM_SPEC']}', style: AppTheme.a15500.copyWith(color: AppTheme.black)),
                                ],
                              ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppTheme.af3f3f3
                        ),
                        child: Row(
                          children: [
                            Text('재고 ', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                            Text('${controller.partList[index]['STOCK_QTY']}', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                      SizedBox(height: 10,),
                ],
              )),
        ),
        controller.isPartSelectedList[index] != true ?
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.af3f3f3,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if(controller.partQtyList[index] > 1) {
                          controller.partQtyList[index] = controller.partQtyList[index] - 1;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 12, bottom: 12),
                        child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme.red_red_200
                            ),
                            child: SvgPicture.asset('assets/app/minus.svg', width: 14, height: 14, color: AppTheme.red_red_900,)),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Text('사용 ', style: AppTheme.a14700.copyWith(color: AppTheme.black)),
                    Text('${controller.partQtyList[index].toString()}', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                    SizedBox(width: 12,),
                    InkWell(
                      onTap: () {
                        controller.partQtyList[index] = controller.partQtyList[index] + 1;
                        Get.log('클릭 ${controller.partList[index]}');

                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15, top: 12, bottom: 12),
                        child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme.blue_blue_200
                            ),
                            child: SvgPicture.asset('assets/app/plus.svg', width: 14, height: 14, color: AppTheme.blue_blue_900,)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ): Container(),
        SizedBox(height: 20,)
      ],
    ));
  }


}
