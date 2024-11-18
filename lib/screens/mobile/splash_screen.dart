import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_beeper/utils/app_colors.dart';

import '../../controller/news_controller.dart';
import '../../utils/mobile/text_styles.dart';
import 'home_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double _deviceHeight, _deviceWidth;

  late NewsController newsController;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void _checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      newsController = Get.put(NewsController());
      await newsController.getLatestNews();
      Get.off(HomeScreen());
    } else {
      _showNoInternetAlert();
    }
  }

  void _showNoInternetAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'No Internet Connection',
          style: TextStyles.alertTitleTextStyle
        ),
        content: const Text(
            'Please turn on your internet connection to proceed.',
            style: TextStyles.alertSubTextStyle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _checkInternetConnection(); // Retry connection check
            },
            child: const Text('Retry', style: TextStyles.retryButtonTextStyle),
          ),
        ],
      ),
    );
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
                width: _deviceWidth * 0.6, height: _deviceHeight * 0.3),
            const SizedBox(height: 20),
            const SizedBox(
              width: 22.0,
              height: 22.0,
              child: CircularProgressIndicator(
                color: AppColors.crimson,
                strokeWidth: 3.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
