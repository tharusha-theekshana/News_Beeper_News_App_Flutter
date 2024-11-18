import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/controller/news_controller.dart';
import 'package:news_beeper/utils/app_colors.dart';

import '../../utils/app_strings.dart';
import '../../utils/mobile/text_styles.dart';
import '../../widgets/mobile/news_list.dart';
import '../../widgets/mobile/search_bar_widget.dart';
import '../../widgets/mobile/theme_icon_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late double _deviceHeight, _deviceWidth;
  final getStorage = GetStorage();

  final NewsController controller = Get.put<NewsController>(NewsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.searchNews = [];
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.02,
                vertical: _deviceHeight * 0.01),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: SearchBarWidget(
                          onSubmit: (value) =>
                              controller.getSearchNews(searchText: value),
                        )),
                    Expanded(flex: 1, child: ThemeIconWidget())
                  ],
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Expanded(
                      child: Center(
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
                  } else if (controller.searchNews.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text("Search ...",style: TextStyles.noResultFountTextStyle),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: _deviceHeight * 0.01),
                        child: NewsList(
                          newsList: controller.searchNews,
                          axis: Axis.vertical,
                          width: _deviceWidth * 0.9,
                          height: _deviceHeight * 0.23,
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
