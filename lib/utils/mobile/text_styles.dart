import 'package:flutter/material.dart';

import '../app_colors.dart';

class TextStyles {
  //App name TextStyle
  static const TextStyle appNameTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: "Quicksand-Medium",
    fontSize: 24.0,
    color: AppColors.crimson,
  );

  //Search bar
  static const TextStyle searchBarStyle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    color: AppColors.gray,
  );

  static const TextStyle searchBarHintTextStyle = TextStyle(
    color: AppColors.gray,
  );

  static const TextStyle latestNewsTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: "Quicksand-Medium",
    color: AppColors.crimson,
  );

  static const TextStyle seeAllTextStyle = TextStyle(
    fontSize: 11.0,
    color: AppColors.blue,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle mainPageNewsCardTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainPageNewsCardAuthorStyle = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        blurRadius: 4.0,
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(2, 2),
      ),
    ],
  );

  // Bottom Navigation Styles
  static TextStyle unSelectedNavLabelStyle = const TextStyle(
    color: AppColors.gray,
    fontFamily: "Quicksand-Medium",
    fontWeight: FontWeight.bold,
    fontSize: 10.0,
  );

  static const TextStyle selectedNavLabelStyle = TextStyle(
    color: AppColors.crimson,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
  );

  //individual news screen
  static const TextStyle dateTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0);

  static const TextStyle titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      fontFamily: "Quicksand-Medium");

  static const TextStyle authorTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0);

  static const TextStyle descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      fontFamily: "Quicksand-Medium");

  static const TextStyle contentTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  );

  static const TextStyle seeMoreTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle noResultFountTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);

  //Tab bar item style
  static const TextStyle tabBarItemStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0);

  //Internet connection alert dialog Text Styles
  static const TextStyle alertTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);

  static const TextStyle alertSubTextStyle = TextStyle(fontSize: 12.0);

  static const TextStyle retryButtonTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.bold, color: AppColors.crimson);

  // Drawer Text Styles
  static const TextStyle appDescriptionTextStyle =
      TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  static const TextStyle createdByTextStyle =
      TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold);

  static const TextStyle developerNameTextStyle = TextStyle(
      color: AppColors.crimson, fontWeight: FontWeight.bold, fontSize: 13.0);

  static const TextStyle versionNumberTextStyle =
      TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold);
}
