import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/controller/bottom_navigation_controller.dart';
import 'package:news_beeper/controller/theme_controller.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/utils/mobile/text_styles.dart';

class BottomNavigationWidget extends StatelessWidget {
  final double deviceHeight;
  final double deviceWidth;
  final PageController pageController;
  final getStorage = GetStorage();

  final ThemeController themeController = Get.put(ThemeController());
  final BottomNavigationController bottomNavController = Get.put(BottomNavigationController());

  BottomNavigationWidget({
    required this.deviceHeight,
    required this.deviceWidth,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: getStorage.read(AppStrings.themeMode) == "dark"
              ? AppColors.lightBlack
              : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: getStorage.read(AppStrings.themeMode) == "dark"
                ? AppColors.lightBlack
                : AppColors.white,
            selectedItemColor: AppColors.crimson,
            currentIndex: bottomNavController.index,
            onTap: (index) {
              bottomNavController.changeBottomNavigation(currentIndex: index);
              pageController.jumpToPage(index);
            },
            unselectedLabelStyle: TextStyles.unSelectedNavLabelStyle,
            selectedLabelStyle: TextStyles.selectedNavLabelStyle,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
                tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
                tooltip: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category),
                label: 'Category',
                tooltip: 'Category',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
