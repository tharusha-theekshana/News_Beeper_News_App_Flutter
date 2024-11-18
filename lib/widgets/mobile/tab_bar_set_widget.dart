import 'package:flutter/material.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/utils/mobile/text_styles.dart';

class TabBarSetWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> list;
  final double deviceWidth;

  const TabBarSetWidget({
    Key? key,
    required this.tabController,
    required this.list,
    required this.deviceWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth,
      height: 35.0,
      child: TabBar(
        isScrollable: true,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.crimson,
          borderRadius: BorderRadius.circular(32),
        ),
        unselectedLabelColor: AppColors.gray,
        labelColor: AppColors.white,
        dividerColor: Colors.transparent,
        tabs: list.map((category) {
          return Tab(
            child: Text(
              category,
              style: TextStyles.tabBarItemStyle,
            ),
          );
        }).toList(),
      ),
    );
  }
}
