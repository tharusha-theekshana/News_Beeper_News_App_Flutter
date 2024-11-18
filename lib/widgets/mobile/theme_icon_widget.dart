import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/theme_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';


class ThemeIconWidget extends StatelessWidget {

  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: ThemeController(),
        builder: (controller) => IconButton(
            onPressed: () {
              controller.changeThemeMode();
            },
            icon: Icon(controller.iconTheme(),size: 23.0, color: getStorage.read(AppStrings.themeMode) ==
                "dark"
                ? AppColors.white
                : AppColors.gray,)
        ),
      );
    }
}
