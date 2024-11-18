import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:news_beeper/screens/web/web_home_page.dart';
import 'package:news_beeper/utils/app_strings.dart';

import '../../controller/news_controller.dart';
import '../../utils/app_colors.dart';

class WebSplashScreen extends StatefulWidget {
  @override
  State<WebSplashScreen> createState() => _WebSplashScreenState();
}

class _WebSplashScreenState extends State<WebSplashScreen> {
  late double _deviceHeight, _deviceWidth;
  final NewsController newsController = Get.put(NewsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    await getAllNews();
    _jumpToHomePage();
  }

  Future<void> getAllNews() async {
    newsController.getLatestNews();
    newsController.webBusinessNews = await newsController.getCategoryNews(category: AppStrings.business);
    newsController.webEntertainmentNews = await newsController.getCategoryNews(category: AppStrings.entertainment);
    newsController.webGeneralNews = await newsController.getCategoryNews(category: AppStrings.general);
    newsController.webHealthNews = await newsController.getCategoryNews(category: AppStrings.health);
    newsController.webScienceNews = await newsController.getCategoryNews(category: AppStrings.science);
    newsController.webSportsNews = await newsController.getCategoryNews(category: AppStrings.sports);
    newsController.webTechnologyNews = await newsController.getCategoryNews(category: AppStrings.technology);
    _jumpToHomePage();
  }

  void _jumpToHomePage() async {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(WebHomePage(),transition: Transition.fadeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_icon.png',
                width: _deviceWidth * 0.6, height: _deviceHeight * 0.4),
            const SizedBox(height: 20),
            const SizedBox(
              width: 22.0,
              height: 22.0,
              child: Center(
                child: LoadingIndicator(
                  indicatorType:  Indicator.ballPulse,
                  colors: [AppColors.crimson],
                  strokeWidth: 4.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
