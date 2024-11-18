import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/widgets/web/category_news_list_widget.dart';
import '../../../controller/news_controller.dart';
import '../../../model/news_model.dart';

class WebSportsCategoryNews extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: CategoryNewsListWidget(
            newsList: newsController.webSportsNews, name: AppStrings.sports));
  }
}
