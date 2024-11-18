import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/controller/news_controller.dart';
import 'package:news_beeper/controller/theme_controller.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/utils/web/web_text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/news_model.dart';
import '../../utils/app_strings.dart';

class WebCarouselSlider extends StatefulWidget {
  const WebCarouselSlider({super.key});

  @override
  State<WebCarouselSlider> createState() => _WebCarouselSliderState();
}

class _WebCarouselSliderState extends State<WebCarouselSlider> {
  late double _deviceHeight, _deviceWidth;
  final NewsController newsController = Get.put(NewsController());
  final getStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    newsController.getLatestNews(); // Fetch news on initialization
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (themeController) {
        return GetBuilder<NewsController>(
          init: newsController,
          builder: (newsController) {
            List<NewsModel> newsList = newsController.latestNews;

            if (newsList.isEmpty) {
              return const Center(
                child: Text("No news available."),
              );
            }

            return CarouselSlider(
              options: CarouselOptions(
                height: 450.0,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
              items: newsList.map((news) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: _deviceWidth * 0.8,
                      margin: EdgeInsets.symmetric(
                        horizontal: _deviceWidth * 0.03,
                        vertical: _deviceHeight * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: getStorage.read(AppStrings.themeMode) == null ||
                            getStorage.read(AppStrings.themeMode) != "dark"
                            ? AppColors.white
                            : AppColors.lightBlack,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: _deviceWidth * 0.01),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  news.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes !=
                                            null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                      ),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/no_news.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: _deviceHeight * 0.02,
                                horizontal: _deviceWidth * 0.01,
                              ),
                              child: _newsData(news),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _newsData(NewsModel news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              news.title!.isNotEmpty
                  ? Text(news.title.toString(),
                  style: WebTextStyles.titleTextStyle)
                  : Container(),
              news.author!.isNotEmpty
                  ? Text(news.author.toString(),
                  style: WebTextStyles.authorTextStyle)
                  : Container(),
              news.publishedAt != ""
                  ? Text(news.publishedAt.toString(),
                  style: WebTextStyles.dateTextStyle)
                  : Container(),
            ],
          ),
        ),
        news.description!.isNotEmpty
            ? Expanded(
          flex: 3,
          child: Text(news.description.toString(),
              style: WebTextStyles.descriptionTextStyle),
        )
            : Expanded(flex: 3, child: Container()),
        news.content!.isNotEmpty
            ? Expanded(
          flex: 3,
          child: Text(news.content.toString(),
              style: WebTextStyles.contentTextStyle),
        )
            : Expanded(flex: 3, child: Container()),
        Expanded(flex: 1, child: _newsLink(news.url.toString())),
      ],
    );
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        width: _deviceWidth * 0.05,
        decoration: BoxDecoration(
          color: AppColors.crimson,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Read More ...', style: WebTextStyles.seeMoreTextStyle),
          ],
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }
}

