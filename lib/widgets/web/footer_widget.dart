import 'package:flutter/material.dart';
import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/utils/web/web_text_styles.dart';

class FooterWidget extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: _deviceWidth,
      height: _deviceHeight * 0.05,
      margin: EdgeInsets.only(top: _deviceHeight * 0.005,bottom: _deviceHeight * 0.01),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Created By ", style: WebTextStyles.footerTextStyle,),
          Text(AppStrings.developerName , style: WebTextStyles.developerNameTextStyle,),
          Text(" || All Right reserved.",style: WebTextStyles.footerTextStyle)
        ],
      )
    );
  }
}
