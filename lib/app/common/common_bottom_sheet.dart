import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../pages/main/main_controller.dart';

class CommonBottomWidget extends StatelessWidget {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationBar(
      backgroundColor: AppTheme.white,
        surfaceTintColor: AppTheme.white,
      onDestinationSelected: (selected) {
        controller.changeMenu(selected);

        controller.selected.value = selected;
      },
      selectedIndex: controller.selected.value,
      destinations: const [
        NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.house,), label: '홈'),
        NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.heart,), label: '두번'),
        NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.gear,), label: '세번'),

      ],
    ));
  }
}
