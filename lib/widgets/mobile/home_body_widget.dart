import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/mobile/top_search_keywords_news_widget.dart';

import 'latest_news_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  final pageController = PageController();

  HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
        height: _deviceHeight,
        width: _deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: LatestNewsWidget()),
            const SizedBox(
              height: 10,
            ),
            Expanded(flex: 10, child: TopSearchKeywordNewsWidget())
          ],
        ),
      ),
    );
  }
}
