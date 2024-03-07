import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ModalUserListWidget extends StatelessWidget {
  ModalUserListWidget({Key? key}) : super(key: key);
  FacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
          height: 500,
          child: CustomScrollView(
            slivers: [
              _title(),
              _listArea(),
             // _bottom(context)
            ],
          ),
    );
  }

  Widget _bottom(BuildContext context) {
    return SliverToBoxAdapter(
      child: Scaffold(
        bottomNavigationBar:  BottomAppBar(
          color: AppTheme.white,
          surfaceTintColor: AppTheme.white,
          child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: controller.registButton.value ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.registButton.value ? () {
               Get.back();
              } : null,
              child: Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      '저장',
                      style: AppTheme.a15700.copyWith(
                        color: AppTheme.black,
                      ),
                    )),
              )),
        ),
      ),
    );
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 12, bottom: 20),
          child: Text('작업자 선택', style: AppTheme.titleHeadline.copyWith(color: AppTheme.black),
          )),
    );
  }

  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.engineer2List.length));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Obx(() => TextButton(
      onPressed: () {
        controller.selectedEnginner.value = '';
        controller.selectedEnginnerCd.value = '';
        controller.isEngineerSelectedList[index] == false ? controller.isEngineerSelectedList[index] = true
            : controller.isEngineerSelectedList[index] = false;
        controller.isEngineerSelectedList[index] == true
            ? controller.engineerSelectedList.add(controller.engineer2List[index])
            : controller.engineerSelectedList.remove(controller.engineer2List[index]);

          for(var i = 0; i < controller.engineerSelectedList.length; i++ ) {
            controller.selectedEnginner.value == '' ?  controller.selectedEnginner.value = controller.engineerSelectedList[i]['USER_NAME'] :
            controller.selectedEnginner.value = '${controller.selectedEnginner.value}' + ', ${controller.engineerSelectedList[i]['USER_NAME']}';

            controller.selectedEnginnerCd.value == '' ? controller.selectedEnginnerCd.value = controller.engineerSelectedList[i]['USER_ID'].toString() :
            controller.selectedEnginnerCd.value = '${controller.selectedEnginnerCd.value}' + ',${controller.engineerSelectedList[i]['USER_ID'].toString()}';
          }

        Get.log('정비자 코드 ::: ${controller.selectedEnginnerCd.value}');


      },
      child: Container(
          decoration: BoxDecoration(
              border: const Border(
                bottom:
                BorderSide(color: AppTheme.light_ui_08),
              )),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 12, top: 16, bottom: 20),
          child: Row(
            children: [
              Row(
                children: [
                  controller.isEngineerSelectedList[index] == false ?
                  Icon(Icons.check_circle, color: AppTheme.gray_c_gray_300, size: 23,) : Icon(Icons.check_circle, color: AppTheme.black, size: 23),
                  SizedBox(width: 15,),
                  Text('${controller.engineer2List[index]['USER_NAME']}', style: AppTheme.a16700.copyWith(color: AppTheme.black),),
                ],
              ),

            ],
          )),
    ));
  }
}
