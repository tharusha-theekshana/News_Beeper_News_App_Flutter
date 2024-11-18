import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/web/web_news_list.dart';

import '../../model/news_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/mobile/text_styles.dart';

class CategoryNewsListWidget extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  final List<NewsModel> newsList;
  final String name;

  CategoryNewsListWidget({required this.newsList, required this.name});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(right: _deviceWidth * 0.005),
      width: _deviceWidth,
      child: newsList.isEmpty
          ? const Center(
        child: Text(
          "No news available.",
          style: TextStyle(color: AppColors.crimson),
        ),
      )
          : Column(
        children: [
          topLine(context),
          Expanded(
            child: WebNewsList(
              newsList: newsList, // Use the provided news list
              height: _deviceHeight,
              width: _deviceWidth * 0.14,
            ),
          ),
        ],
      ),
    );
  }

  Widget topLine(BuildContext context) {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.symmetric(vertical: _deviceHeight * 0.02),
      child: Text(
        "$name News",
        style: TextStyles.latestNewsTextStyle,
      ),
    );
  }
}
