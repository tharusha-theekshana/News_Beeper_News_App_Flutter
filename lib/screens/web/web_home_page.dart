import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/web/category_news_lists/web_entertainment_category_news.dart';
import 'package:news_beeper/widgets/web/category_news_lists/web_medical_category_news.dart';
import 'package:news_beeper/widgets/web/category_news_lists/web_sports_category_news.dart';
import 'package:news_beeper/widgets/web/category_news_lists/web_technology_category_news.dart';
import 'package:news_beeper/widgets/web/footer_widget.dart';
import 'package:news_beeper/widgets/web/web_carousel_slider.dart';
import 'package:news_beeper/widgets/web/web_drawer_widget.dart';
import 'package:news_beeper/widgets/web/category_news_lists/web_general_category_news.dart';

import '../../utils/app_strings.dart';
import '../../utils/web/web_text_styles.dart';
import '../../widgets/mobile/theme_icon_widget.dart';
import '../../widgets/web/category_news_lists/web_business_category_news.dart';

class WebHomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          AppStrings.appName,
          style: WebTextStyles.appNameTextStyle,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20, top: 5),
            child: ThemeIconWidget(),
          ),
        ],
      ),
      drawer: WebDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBody(),
            Divider(
              thickness: 1.0,
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: _deviceWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: _deviceWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 7, child: WebCarouselSlider()),
                  Expanded(flex: 4, child: WebVerticalCarousel()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: _deviceHeight * 0.25,
            child: WebBusinessCategoryNews(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: _deviceHeight * 0.25,
            child: WebEntertainmentCategoryNews(),
          ),
          const SizedBox(height: 20), // Add spacing
          SizedBox(
            height: _deviceHeight * 0.25,
            child: WebTechnologyCategoryNews(),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: _deviceHeight * 0.1),
              child: WebMedicalCategoryNews()),
          SizedBox(
            height: _deviceHeight * 0.25,
            child: WebSportsCategoryNews(),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
