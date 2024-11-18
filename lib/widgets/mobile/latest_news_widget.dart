import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/controller/news_controller.dart';

import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/utils/mobile/text_styles.dart';


import '../../model/news_model.dart';
import '../../screens/mobile/latest_news_screen.dart';
import 'news_list.dart';

class LatestNewsWidget extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
      height: _deviceHeight * 0.5,
      child: GetBuilder<NewsController>(
          init: NewsController(),
          builder: (controller) {
            int newsListLength = controller.latestNews.length;
            List<NewsModel> firstTenNews = controller.latestNews.sublist(
              0,
              newsListLength < 10 ? newsListLength : 10, // Take 10 or the list length, whichever is smaller
            );

            return Column(
              children: [
                topLine(context),
                Expanded(
                    child: NewsList(
                  newsList: firstTenNews,
                  axis: Axis.horizontal,
                  height: _deviceHeight * 0.2,
                  width: _deviceWidth * 0.8,
                ))
              ],
            );
          }),
    );
  }

  Widget topLine(context) {
    return Container(
      width: _deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.latestNews,
            style: TextStyles.latestNewsTextStyle,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LatestNewsScreen();
                  },
                ));
              },
              child: const Text(
                "Sea all -->",
                style: TextStyles.seeAllTextStyle,
              ))
        ],
      ),
    );
  }
}
