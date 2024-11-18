import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/mobile/theme_icon_widget.dart';

import '../../utils/app_strings.dart';
import '../../utils/mobile/text_styles.dart';


class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        AppStrings.appName,
        style: TextStyles.appNameTextStyle
      ),
      actions: [
        ThemeIconWidget(), // Custom action widget
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
