import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:news_beeper/controller/news_controller.dart';
import 'package:news_beeper/utils/app_strings.dart';


import '../../utils/mobile/text_styles.dart';
import '../../widgets/mobile/news_list.dart';
import '../../widgets/mobile/theme_icon_widget.dart';

class LatestNewsScreen extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.latestNews,
          style: TextStyles.appNameTextStyle,
        ),
        actions: [
          ThemeIconWidget()
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.015),
            child: NewsList(
              newsList: controller.latestNews,
              axis: Axis.vertical,
              width: _deviceWidth,
              height: _deviceHeight * 0.22,
            ),
          );
        });
  }
}
