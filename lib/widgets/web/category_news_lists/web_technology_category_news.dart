import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/widgets/web/category_news_list_widget.dart';
import '../../../controller/news_controller.dart';
import '../../../model/news_model.dart';
import '../../../utils/app_strings.dart';

class WebTechnologyCategoryNews extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: CategoryNewsListWidget(
          newsList: newsController.webTechnologyNews, name: AppStrings.technology),
    );
  }
}
