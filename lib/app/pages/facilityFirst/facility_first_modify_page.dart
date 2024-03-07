import 'package:dio/dio.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/back_dialog_widget.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';

import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class FacilityFirstModifyPage extends StatefulWidget {
  const FacilityFirstModifyPage({Key? key}) : super(key: key);

  @override
  State<FacilityFirstModifyPage> createState() => _FacilityFirstStep2PageState();
}

class _FacilityFirstStep2PageState extends State<FacilityFirstModifyPage> {
  FacilityFirstController controller = Get.find();
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackKey();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CommonAppbarWidget(title: '설비/안전 점검 - 의뢰내역 수정', isLogo: false, isFirstPage: false, facilityFlag: true ),
              _bodyArea(context),
              //_streamBuilder()

            ],
          ),
        ),
        bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
      ),
    );
  }

  Future<bool> _onBackKey() async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                  Text(
                    '',
                    style: AppTheme.a18700
                        .copyWith(color: AppTheme.black),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: SizedBox(
                height: 70,
                child: Column(
                  children: [
                    Text('저장되지 않은 내역이 있을 수 있습니다.', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                    Text('계속하시겠습니까?', style: AppTheme.a15800.copyWith(color: AppTheme.black),),
                  ],
                ),
              ),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0x5c3c3c43),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () {
                              Get.log('취소 클릭!');
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: const Color(0x5c3c3c43),)
                                  )
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacing_s_12,
                                bottom: AppTheme.spacing_s_12,
                              ),
                              child: Center(
                                child: Text('취소',
                                    style: AppTheme.titleHeadline.copyWith(
                                        color: AppTheme.black,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () {
                              Get.log('확인 클릭!');
                              Get.offAllNamed(Routes.FACILITY_FIRST);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacing_s_12,
                                bottom: AppTheme.spacing_s_12,
                              ),
                              child: Center(
                                child: Text('확인',
                                    style: AppTheme.titleHeadline.copyWith(
                                        color: AppTheme.black,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]);
        });
    return false;
  }

  Widget _bodyArea(BuildContext context) {
    controller.modifyErrorTime2.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _basicContainerItem(context, '의뢰번호', '자동생성', 1),
              _basicContainerItem(context, '장애일시', '${controller.modifyErrorTime.value}', 2),
              controller.isModifyErrorDateChoice.value == true ?
              Column(
                children: [
                  SizedBox(height: 16,),
                  _errorDateSelect(),
                ],
              ) : Container(),
              SizedBox(height: 20,),
              _inspectionGubunItem(context),
              controller.modifySelectedIns.value == '안전점검' ? Container() :
              Column(
                children: [
                  SizedBox(height: 20,),
                  _facilityChoiceItem(context),
                ],
              ),
              SizedBox(height: 20,),
              controller.modifySelectedMachMap['MACH_NAME'] == '전체' ? _anotherFacilityItem() : Container(),
              SizedBox(height: 20,),
              _engineTeamItem(context),
              SizedBox(height: 20,),
              _titleTextFieldItem(),
              SizedBox(height: 20,),
              _contentTextFieldItem(),
              SizedBox(height: 20,),
              _fileArea(),
              SizedBox(height: 20,),
              _imageArea()
              // _topDataItem(),
              //_inputArea(context),
              // _partChoiceBody()
            ],
          ),
        ),)
    );
  }
  /*Widget _streamBuilder() {
    return SliverToBoxAdapter(
      child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (c, snapshot) {
            return Container(
              child: (() {
                controller.step2RegistBtn();
              }()),
            );
          }),
    );
  }
*/

  /// 의뢰번호, 장애일시
  Widget _basicContainerItem(BuildContext context, String title, String content, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: flag == 1 ? 14 : 0, bottom: flag == 1 ? 14 : 0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.gray_gray_200))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(content
                , style: AppTheme.a16400.copyWith(color: flag == 1 ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),),
              flag == 2 ?
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                onPressed: () {
                  controller.isModifyErrorDateChoice.value = true;
                },
                child: Container(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.red_red_100,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text('수정', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black)),
                ),
              ) : Container()
            ],
          ),
        )
      ],
    );
  }

  /// 점검/의뢰 구분
  Widget _inspectionGubunItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('점검/의뢰 구분',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(3),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    icon: SvgPicture.asset(
                      'assets/app/arrowBottom.svg',
                      color: AppTheme.light_placeholder,
                    ),
                    dropdownColor: AppTheme.light_ui_01,
                    value: controller.modifySelectedIns.value,
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.modifyInsList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.modifySelectedIns.value = value!;

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton<String>(//
                    borderRadius: BorderRadius.circular(3),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    icon: SvgPicture.asset(
                      'assets/app/arrowBottom.svg',
                      color: AppTheme.light_placeholder,
                    ),
                    dropdownColor: AppTheme.light_ui_01,
                    value: controller.modifySelectedReadUrgency.value,
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.modifyUrgencyList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.modifySelectedReadUrgency.value = value!;
                     // value == '긴급' ?  controller.modifyIrCode.value = 'U' :  controller.modifyIrCode.value = 'N';

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),
              ),
            ),
          ],
        )
      ],
    );
  }

  /// 설비
  Widget _facilityChoiceItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('설비',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Container(
          height: 50,
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )),
          padding: const EdgeInsets.only( right: 12),
          child: DropdownButton(
              borderRadius: BorderRadius.circular(3),
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.white,
              ),
              icon: SvgPicture.asset(
                'assets/app/arrowBottom.svg',
                color: AppTheme.light_placeholder,
              ),
              dropdownColor: AppTheme.light_ui_01,
              value: controller.modifySelectedMachMap['MACH_NAME'],
              //  flag == 3 ? controller.selectedNoReason.value :
              items: controller.modifyMachList.map((value) {
                return DropdownMenuItem<String>(
                  value: value['MACH_NAME'],
                  child: Text(
                    value['MACH_NAME'],
                    style: AppTheme.a16400
                        .copyWith(color: value['MACH_NAME'] == '전체' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                controller.modifyMachList.map((e) {
                  if(e['MACH_NAME'] == value) {
                    controller.modifySelectedMachMap['MACH_CODE'] = e['MACH_CODE'].toString();
                    controller.modifySelectedMachMap['MACH_NAME'] = e['MACH_NAME'];
                  }
                  //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                }).toList();
                Get.log('설비 코드 ::::::::: ${controller.modifySelectedMachMap['MACH_CODE']}');
              }),
        ),

      ],
    );
  }

  /// 설비 외
  Widget _anotherFacilityItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('설비 외',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            // maxLines: 5,
            controller: controller.modifyTextFacilityController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '설비가 없는경우 직접 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
      ],
    );
  }

  /// 정비 유형 정비부서
  Widget _engineTeamItem(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('정비유형',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton(
                    dropdownColor: AppTheme.light_ui_01,
                    borderRadius: BorderRadius.circular(3),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    icon: SvgPicture.asset(
                      'assets/app/arrowBottom.svg',
                      color: AppTheme.light_placeholder,
                    ),
                    value: controller.modifySelectedIrFqMap['TEXT'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.modifyIrfgList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['TEXT'],
                        child: Text(
                          value['TEXT'],
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.modifyIrfgList.map((e) {
                        if(e['TEXT'] == value) {
                            controller.modifySelectedIrFqMap['TEXT'] = e['TEXT'];
                            controller.modifySelectedIrFqMap['CODE'] = e['CODE'];
                        }

                        //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                      }).toList();

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),
              ),
            ],
          ),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('점검부서',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(3),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    icon: SvgPicture.asset(
                      'assets/app/arrowBottom.svg',
                      color: AppTheme.light_placeholder,
                    ),
                    dropdownColor: AppTheme.light_ui_01,
                    value: controller.modifyEngineTeamCdMap['TEXT'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.modifyEngineTeamList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['TEXT'],
                        child: Text(
                          value['TEXT'],
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.modifyEngineTeamList.map((e) {
                        if(e['TEXT'] == value) {
                            controller.modifyEngineTeamCdMap['TEXT'] = e['TEXT'];
                            controller.modifyEngineTeamCdMap['CODE'] = e['CODE'];
                        }

                        //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                      }).toList();

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }


  /// 의뢰제목
  Widget _titleTextFieldItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('의뢰제목',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            // maxLines: 5,
            maxLength: 30,
            controller: controller.modifyTextTitleController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              counterText:'',
              hintText: '제목을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('최대 30글자', style: AppTheme.bodyCaption.copyWith(color: AppTheme.light_text_secondary),
              textAlign: TextAlign.end,),
          ],
        )
      ],
    );
  }

  /// 상세내용
  Widget _contentTextFieldItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('상세내용',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 16,),
        Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            maxLength: 60,
            maxLines: 5,
            controller: controller.modifyTextContentController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText:'',
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '내용을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.light_placeholder),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('최대 60글자', style: AppTheme.bodyCaption.copyWith(color: AppTheme.light_text_secondary),
              textAlign: TextAlign.end,),
          ],
        )
      ],
    );
  }


  Widget _fileAddBtn() {
    return controller.resultFile1 != null && controller.resultFile2 != null && controller.resultFile3 != null && controller.resultFile4 != null
        ? const SizedBox()
        : TextButton(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(AppTheme.gray_gray_100),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
      ),
      onPressed: () async {
        _checkPermission(context);
        Get.log('첨부파일 추가');
        if (controller.resultFile1 == null) {
          controller.resultFile1 = await ImagePicker().pickImage(source: ImageSource.gallery);
          var unit = controller.resultFile1?.readAsBytes();
          Uint8List list = await unit!;
          var image = MemoryImage(list);
          controller.imageList.isNotEmpty ? controller.imageList[0] = image :
          controller.imageList.add(image);
        //  controller.reqNewFileDownloadData(controller.resultFile1!.path);
        } else if (controller.resultFile2 == null) {
          controller.resultFile2 = await ImagePicker().pickImage(source: ImageSource.gallery);
          var unit = controller.resultFile2?.readAsBytes();
          Uint8List list = await unit!;
          var image = MemoryImage(list);
          controller.imageList.length > 1 ? controller.imageList[1] = image :
          controller.imageList.add(image);
        //  controller.reqNewFileDownloadData(controller.resultFile2!.path);
        }else if (controller.resultFile3 == null) {
          controller.resultFile3 = await ImagePicker().pickImage(source: ImageSource.gallery);
          var unit = controller.resultFile3?.readAsBytes();
          Uint8List list = await unit!;
          var image = MemoryImage(list);
          controller.imageList.length > 2 ? controller.imageList[2] = image :
          controller.imageList.add(image);
         // controller.reqNewFileDownloadData(controller.resultFile3!.path);
        }else if (controller.resultFile4 == null) {
          controller.resultFile4 = await ImagePicker().pickImage(source: ImageSource.gallery);
          var unit = controller.resultFile4?.readAsBytes();
          Uint8List list = await unit!;
          var image = MemoryImage(list);
          controller.imageList.length > 3 ? controller.imageList[3] = image :
          controller.imageList.add(image);
        //  controller.reqNewFileDownloadData(controller.resultFile4!.path);
        }

        setState(() {});
      },
      child: SizedBox(
        height: 99,
        width: 99,
        child: Center(
            child: Icon(Icons.picture_in_picture_outlined)/*Image.asset(
            'assets/app/icon_plus_24_2_px.png',
            width: 24,
            height: 24,
          ),*/
        ),
      ),
    );
  }

  Widget _fileLlistArea() {
    return Container(
      width: controller.resultFile1 != null && controller.resultFile2 != null && controller.resultFile3 != null && controller.resultFile4 != null
          ?  MediaQuery.of(context).size.width - 80 : MediaQuery.of(context).size.width - 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            controller.resultFile1 == null
                ? const SizedBox()
                : _fileContainer(
              title: controller.resultFile1!.path != '' ? controller.resultFile1!.name : controller.fileList.isNotEmpty ? controller.fileList[0]['FILE_NAME'] : '',
              firstSecondFlag: 1,
              fileExtension: controller.resultFile1!.path,
            ),
            const SizedBox(
              width: AppTheme.spacing_m_16,
            ),
            controller.resultFile2 == null
                ? const SizedBox()
                : _fileContainer(
              title:  controller.resultFile2!.path != '' ? controller.resultFile2!.name :  controller.fileList.isNotEmpty ? controller.fileList[1]['FILE_NAME']: '',
              firstSecondFlag: 2,
              fileExtension: controller.resultFile2!.path,
            ),
            const SizedBox(
              width: AppTheme.spacing_m_16,
            ),
            controller.resultFile3 == null
                ? const SizedBox()
                : _fileContainer(
              title:  controller.resultFile3!.path != '' ? controller.resultFile3!.name :  controller.fileList.isNotEmpty ? controller.fileList[2]['FILE_NAME']: '',
              firstSecondFlag: 3,
              fileExtension: controller.resultFile3!.path,
            ),
            const SizedBox(
              width: AppTheme.spacing_m_16,
            ),
            controller.resultFile4 == null
                ? const SizedBox()
                : _fileContainer(
              title:  controller.resultFile4!.path != '' ? controller.resultFile4!.name :  controller.fileList.isNotEmpty ? controller.fileList[3]['FILE_NAME']: '',
              firstSecondFlag: 4,
              fileExtension: controller.resultFile4!.path,
            ),

          ],
        ),
      ),
    );
  }

  Widget _fileArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '사진(최대 4장)',
          style: AppTheme.a15700
              .copyWith(color: AppTheme.light_text_primary),
        ),
        const SizedBox(
          height: AppTheme.spacing_xxs_4,
        ),
        Text(
          '의뢰내용과 관련된 사진을 올려주세요',
          style: AppTheme.a16400
              .copyWith(color: AppTheme.a969696),
        ),
        const SizedBox(
          height: AppTheme.spacing_m_16,
        ),
        Row(
          children: [
            _fileAddBtn(),
            const SizedBox(
              width: AppTheme.spacing_m_16,
            ),
            _fileLlistArea(),
          ],
        ),


      ],
    );
  }

  Widget _fileContainer({
    required String title,
    required int firstSecondFlag,
    required String fileExtension,
  }) {
    var imageUrl = 'assets/app/pdfImage.png';

    if (fileExtension!.endsWith("png")) {
      imageUrl = 'assets/app/pdfImage.png';
    } else {
      imageUrl = 'assets/app/pngImage.png';
    }

    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(AppTheme.spacing_s_12),
            decoration:
            BoxDecoration(
                border: Border.all(color: AppTheme.light_ui_03),
                borderRadius: BorderRadius.circular(100)
            ),
            height: 99,
            width: 99,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imageUrl,
                  width: 36,
                  height: 36,
                ),
                const SizedBox(
                  height: AppTheme.spacing_xxs_4,
                ),
                Text(
                  title,
                  style: AppTheme.bodyCaption
                      .copyWith(color: AppTheme.light_text_primary),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            )),
        Positioned(
            right: -7,
            top: -5,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (firstSecondFlag == 1) {
                      if(controller.fileSeqList.isNotEmpty) {
                        for(var i = 0; i < controller.fileList.length; i++ ) {
                          controller.fileList[i]['SEQ'] == controller.fileSeqList[0] ?
                          controller.fileDelList.add(controller.fileList[i]) : null;
                        }
                      }
                      Get.log('fileList0 ::: ${controller.fileList}');
                      controller.resultFile1 = null;
                      if(controller.resultFile1 == null && controller.resultFile2 == null && controller.resultFile3 == null && controller.resultFile4 == null) {
                        controller.imageList.clear();
                      }
                    //  controller.imageList.removeAt(0);
                  } else if(firstSecondFlag == 2){
                    if(controller.fileSeqList.length > 1) {
                      for(var i = 0; i < controller.fileList.length; i++ ) {
                        controller.fileList[i]['SEQ'] == controller.fileSeqList[1] ?
                        controller.fileDelList.add(controller.fileList[i]) : null;
                      }
                    }
                    Get.log('fileList1 ::: ${controller.fileList}');
                    controller.resultFile2 = null;
                    if(controller.resultFile1 == null && controller.resultFile2 == null && controller.resultFile3 == null && controller.resultFile4 == null) {
                      controller.imageList.clear();
                    }
                 //   controller.imageList.removeAt(1);
                  }else if(firstSecondFlag == 3){
                    if(controller.fileSeqList.length > 2) {
                      for(var i = 0; i < controller.fileList.length; i++ ) {
                        controller.fileList[i]['SEQ'] == controller.fileSeqList[2] ?
                        controller.fileDelList.add(controller.fileList[i]) : null;
                      }
                    }
                    Get.log('fileList2 ::: ${controller.fileList}');
                    controller.resultFile3 = null;
                    if(controller.resultFile1 == null && controller.resultFile2 == null && controller.resultFile3 == null && controller.resultFile4 == null) {
                      controller.imageList.clear();
                    }
                 //   controller.imageList.removeAt(2);
                  }else {
                    if(controller.fileSeqList.length > 3) {
                      for(var i = 0; i < controller.fileList.length; i++ ) {
                        controller.fileList[i]['SEQ'] == controller.fileSeqList[3] ?
                        controller.fileDelList.add(controller.fileList[i]) : null;
                      }
                    }

                    Get.log('fileList3 ::: ${controller.fileList}');
                    controller.resultFile4 = null;
                    if(controller.resultFile1 == null && controller.resultFile2 == null && controller.resultFile3 == null && controller.resultFile4 == null) {
                      controller.imageList.clear();
                    }
                 //   controller.imageList.removeAt(3);
                  }
                });
              },
              icon: Container(
                padding: const EdgeInsets.all(AppTheme.spacing_xxs_4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppTheme.light_danger,
                ),
                child: SvgPicture.asset(
                  'assets/app/minus.svg',
                  width: 12,
                  height: 12,
                  color: AppTheme.light_ui_background,
                ),
              ),
            )),
      ],
    );
  }

  Widget _imageArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이미지',
          style: AppTheme.a15700
              .copyWith(color: AppTheme.light_text_primary),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            _imageLlistArea()
          ],
        ),
        const SizedBox(
          height: 100,
        ),

      ],
    );
  }


  Widget _imageLlistArea() {
    return Container(
      width:  MediaQuery.of(context).size.width - 80 ,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            controller.resultFile1 == null
                ? const SizedBox()
                : controller.resultFile1!.path == null ? Container() : controller.imageList.isNotEmpty ? _imageContainer(
             index: 0
            ) : Container(),
            const SizedBox(
              width: 20,
            ),
            controller.resultFile2 == null
                ? const SizedBox()
                : controller.resultFile2!.path == null ? Container() : controller.imageList.isNotEmpty ? _imageContainer(
                index: 1
            ) : Container(),
            const SizedBox(
              width: 20,
            ),
            controller.resultFile3 == null
                ? const SizedBox()
                : controller.resultFile3!.path == null ? Container() : controller.imageList.isNotEmpty ? _imageContainer(
                index: 2
            ) : Container(),
            const SizedBox(
              width: 20,
            ),
            controller.resultFile4 == null
                ? const SizedBox()
                : controller.resultFile4!.path == null ? Container() : controller.imageList.isNotEmpty ? _imageContainer(
                index: 3
            ) : Container()

          ],
        ),
      ),
    );
  }

  Widget _imageContainer({
    required int index,
  }) {
    return controller.imageList.isNotEmpty ?
        InkWell(
          onTap: () {
            _imageShowDialog(context, index);
          },
          child: Container(
              height: 70,
              width: 50,
              child: Image(image: controller.imageList[index]!, fit: BoxFit.fill)),
        ) : Container();
  }

  void _imageShowDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height - 150,
                      child: Image(image: controller.imageList[index]!))
                ],
              ),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Container(
                  child: (() {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(

                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0))),
                              onPressed: () {
                                Get.log('닫기 클릭!');
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(color: const Color(0x5c3c3c43),)
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                  top: AppTheme.spacing_s_12,
                                  bottom: AppTheme.spacing_s_12,
                                ),
                                child: Center(
                                  child: Text('닫기',
                                      style: AppTheme.titleHeadline.copyWith(
                                          color: AppTheme.black,
                                          fontSize: 17)),
                                ),
                              ),
                            ),
                          )]);
                  })(),
                ),
              ]);
        });
  }

  Widget _bottomButton(BuildContext context) {
    return BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: (() {
                  return TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () async {

                        controller.filePathList.clear();
                        controller.cdConvert();
                        await controller.modifySaveButton();
                        _submmit();
                        for(var i = 0; i < controller.fileDelList.length; i++ ) {
                          controller.deleteFileData(controller.fileDelList[i]['SEQ']);
                        }
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          Get.dialog(_dialog());
                        });
                        // controller.check();
                      },
                      child: SizedBox(
                        height: 56,
                        // width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                              '수정완료',
                              style: AppTheme.bodyBody2.copyWith(
                                color: AppTheme.white,
                              ),
                            )),
                      ));
                })(),
              ),
            ),
          ],
        )
    );
  }

  Widget _dialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      scrollable: true,
      content: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Center(
          child: Text(
            '수정되었습니다',
            style: AppTheme.bodyBody2,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        ),
      ),
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 16, bottom: 12),
      actions: [
        Material(
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5)))),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            // 성공
            onPressed: () {
              Get.offAllNamed(Routes.FACILITY_FIRST);
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
    );
  }

  /// 파일 저장쿼리 넘기기
  void _submmit() async {
    try {
      const maxFileSize = 1024 * 1024 * 10;
      if (controller.resultFile1 != null && controller.resultFile1!.path != '') {
        String fileNm = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
        Uint8List? bytes = await controller.resultFile1?.readAsBytes();
        String path = await HomeApi.to.FILE_UPLOAD('MBS0200\\$fileNm(1).jpg', bytes!);
        var retVal = await HomeApi.to.PROC('USP_MBS0200_S01', {'p_WORK_TYPE':'FILE_N', '@p_IR_CODE':controller.selectedContainer[0]['IR_CODE'],
          '@p_FILE_NAME': controller.resultFile1!.name, '@p_SVR_FILE_PATH': path, '@p_SEQ':'0', '@p_USER': Utils.getStorage.read('userId'), '@p_IR_TITLE': controller.selectedContainer[0]['IR_TITLE']});
        Get.log('경로 테스트::: $path');
        /*
          if (maxFileSize < bytes) {
            Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
            return;
          }
      */

      }
      if (controller.resultFile2 != null && controller.resultFile2!.path != '') {
        String fileNm = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
        Uint8List? bytes = await controller.resultFile2?.readAsBytes();

        String path = await HomeApi.to.FILE_UPLOAD('MBS0200\\$fileNm(2).jpg', bytes!);
        var retVal = await HomeApi.to.PROC('USP_MBS0200_S01', {'p_WORK_TYPE':'FILE_N', '@p_IR_CODE':controller.selectedContainer[0]['IR_CODE'],
          '@p_FILE_NAME': controller.resultFile2!.name, '@p_SVR_FILE_PATH': path, '@p_SEQ':'1', '@p_USER': Utils.getStorage.read('userId'), '@p_IR_TITLE': controller.selectedContainer[0]['IR_TITLE']});
        Get.log('경로 테스트::: $path');
      }
      if (controller.resultFile3 != null && controller.resultFile3!.path != '') {
        String fileNm = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
        Uint8List? bytes = await controller.resultFile3?.readAsBytes();

        String path = await HomeApi.to.FILE_UPLOAD('MBS0200\\$fileNm(3).jpg', bytes!);
        var retVal = await HomeApi.to.PROC('USP_MBS0200_S01', {'p_WORK_TYPE':'FILE_N', '@p_IR_CODE':controller.selectedContainer[0]['IR_CODE'],
          '@p_FILE_NAME': controller.resultFile3!.name, '@p_SVR_FILE_PATH': path, '@p_SEQ':'2', '@p_USER': Utils.getStorage.read('userId'), '@p_IR_TITLE': controller.selectedContainer[0]['IR_TITLE']});
        Get.log('경로 테스트::: $path');
        Get.log('fileNm:: $fileNm');

      }
      if (controller.resultFile4 != null && controller.resultFile4!.path != '') {
        String fileNm = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
        Get.log('fileNm:: ${fileNm}');
        Uint8List? bytes = await controller.resultFile4?.readAsBytes();
 /*       if (maxFileSize < bytes!.length) {
          Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
          return;
        }*/
        String path = await HomeApi.to.FILE_UPLOAD('MBS0200\\$fileNm(4).jpg', bytes!);
        var retVal = await HomeApi.to.PROC('USP_MBS0200_S01', {'p_WORK_TYPE':'FILE_N', '@p_IR_CODE':controller.selectedContainer[0]['IR_CODE'],
          '@p_FILE_NAME': controller.resultFile4!.name, '@p_SVR_FILE_PATH': path, '@p_SEQ':'3', '@p_USER': Utils.getStorage.read('userId'), '@p_IR_TITLE': controller.selectedContainer[0]['IR_TITLE']});
        Get.log('경로 테스트::: $path');
      }


    } catch (err) {
      Get.log('_submmit err = ${err.toString()} ', isError: true);
    } finally {

    }
  }

  Widget _errorDateSelect() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              onPressed: () async{
                var datePicked = await DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      controller.isModifyErrorDateChoice.value = false;
                      var firstIndex = date
                          .toString().lastIndexOf(':');
                      var lastIndex = date
                          .toString().length;
                      controller.modifyErrorTime.value = date.toString().replaceRange(firstIndex, lastIndex, '');
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);

                Get.log('${datePicked}');
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.gray_gray_200))
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('날짜를 선택해주세요', style: AppTheme.bodyBody1
                        .copyWith(color: AppTheme.black),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, Uint8List data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xs_8,
                  ),
                  Container(
                    child: Image.memory(data),
                  ),
                  SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                ],
              ),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Container(
                  child: (() {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)))),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0))),
                              onPressed: () {
                                Get.log('취소 클릭!');
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(color: const Color(0x5c3c3c43),)
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                  top: AppTheme.spacing_s_12,
                                  bottom: AppTheme.spacing_s_12,
                                ),
                                child: Center(
                                  child: Text('닫기',
                                      style: AppTheme.titleHeadline.copyWith(
                                          color: AppTheme.black,
                                          fontSize: 17)),
                                ),
                              ),
                            ),
                          )]);
                  })(),
                ),
              ]);
        });
  }
  void _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      //openCameraGallery();
      //_openDialog(context);
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;

  }
}

