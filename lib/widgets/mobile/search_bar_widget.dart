import 'package:flutter/material.dart';
import 'package:news_beeper/utils/mobile/text_styles.dart';

import '../../utils/app_colors.dart';


class SearchBarWidget extends StatelessWidget {
  final Function(String) onSubmit;
  final TextEditingController? controller;

  SearchBarWidget({required this.onSubmit,this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextField(
        maxLength: 30,
        onSubmitted: onSubmit,
        style: TextStyles.searchBarStyle,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Search ...",
          hintStyle: TextStyles.searchBarHintTextStyle,
          prefixIcon: const Icon(Icons.search,color: AppColors.gray),
          prefixIconColor: Colors.black,
        ),
        cursorColor: AppColors.gray,
      ),
    );
  }
}
