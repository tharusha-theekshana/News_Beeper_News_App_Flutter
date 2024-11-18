import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/controller/bottom_navigation_controller.dart';
import 'package:news_beeper/screens/mobile/category_screen.dart';
import 'package:news_beeper/screens/mobile/search_screen.dart';
import 'package:news_beeper/widgets/mobile/drawer_widget.dart';
import 'package:news_beeper/widgets/mobile/home_body_widget.dart';

import '../../widgets/mobile/bottom_navigation_widget.dart';
import '../../widgets/mobile/custome_app_bar_widget.dart';




class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceHeight, _deviceWidth;

  final pageController = PageController();
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      builder: (controller) => Scaffold(
        appBar: controller.index != 1 ? CustomAppBarWidget() : null,
        drawer: DrawerWidget(),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    controller.changeBottomNavigation(currentIndex: index);
                  },
                  children: [
                    HomeBodyWidget(),
                    SearchScreen(),
                    CategoryScreen(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: BottomNavigationWidget(
                    deviceHeight: _deviceHeight,
                    deviceWidth: _deviceWidth,
                    pageController: pageController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
