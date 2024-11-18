import 'package:flutter/material.dart';

import '../app_colors.dart';

class WebTextStyles {
  //App name TextStyle
  static const TextStyle appNameTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: "Quicksand-Medium",
    fontSize: 32.0,
    color: AppColors.crimson,
  );

  static const TextStyle mainPageNewsCardTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  //Horizontal carousel TextStyles
  static const TextStyle dateTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0);

  static const TextStyle titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      fontFamily: "Quicksand-Medium");

  static const TextStyle authorTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0);

  static const TextStyle descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      fontFamily: "Quicksand-Medium");

  static const TextStyle contentTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
  );

  static const TextStyle seeMoreTextStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Vertical carousel TextStyles
  static const TextStyle vTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      fontFamily: "Quicksand-Medium");

  static const TextStyle vDateTextStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0);

  static const TextStyle vAuthorTextStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0);


  // Medical Category TextStyles
  static const TextStyle mTitleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.0,
      color: AppColors.white,
      fontFamily: "Quicksand-Medium");

  static const TextStyle mDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
      color: AppColors.white,
      fontFamily: "Quicksand-Medium");


  // Footer
  static const TextStyle footerTextStyle=
  TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0);

  static const TextStyle developerNameTextStyle = TextStyle(
      color: AppColors.crimson, fontWeight: FontWeight.bold, fontSize: 15.0);

}
