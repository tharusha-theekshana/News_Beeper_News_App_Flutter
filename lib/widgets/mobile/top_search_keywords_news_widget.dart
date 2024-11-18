import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/controller/news_controller.dart';
import 'package:news_beeper/controller/theme_controller.dart';
import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/widgets/mobile/tab_bar_set_widget.dart';

import '../../shared/most_famous_topics.dart';
import '../../utils/app_colors.dart';
import 'news_list.dart';

class TopSearchKeywordNewsWidget extends StatefulWidget {
  @override
  State<TopSearchKeywordNewsWidget> createState() => _TopSearchKeywordNewsWidgetState();
}

class _TopSearchKeywordNewsWidgetState extends State<TopSearchKeywordNewsWidget>
    with SingleTickerProviderStateMixin {
  late double _deviceHeight, _deviceWidth;

  final getStorage = GetStorage();

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: MostFamousTopics.mostFamousTopics.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _deviceHeight * 0.015,
                  ),
                  TabBarSetWidget(tabController: tabController, list: MostFamousTopics.mostFamousTopics , deviceWidth: _deviceWidth),
                  SizedBox(
                    height: _deviceHeight * 0.02,
                  ),
                  _newsListOfCategories()
                ],
              ),
            )));
  }

  Widget _newsListOfCategories(){
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: MostFamousTopics.mostFamousTopics.map((e) {
          return GetBuilder<NewsController>(
            init: NewsController(),
            builder: (controller) => FutureBuilder(
              future: tabController.indexIsChanging || tabController.index == 0 ? controller.getNewsForFamousTopics(topic: e) : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NewsList(
                      newsList: snapshot.data!,
                      axis: Axis.vertical,
                      width: _deviceWidth,
                      height: _deviceHeight * 0.27);
                } else {
                  return GetBuilder<ThemeController>(
                    init: ThemeController(),
                    builder: (controller) => Center(
                      child: SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(
                          color: getStorage.read(AppStrings.themeMode) ==
                              "dark"
                              ? AppColors.white
                              : AppColors.gray,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
