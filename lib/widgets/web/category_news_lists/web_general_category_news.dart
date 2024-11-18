import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/controller/news_controller.dart';
import 'package:news_beeper/controller/theme_controller.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/utils/web/web_text_styles.dart';

import '../../../model/news_model.dart';
import '../../../utils/app_strings.dart';
import '../web_individual_news_details_popup.dart';

class WebVerticalCarousel extends StatefulWidget {
  @override
  State<WebVerticalCarousel> createState() => _WebVerticalCarouselState();
}

class _WebVerticalCarouselState extends State<WebVerticalCarousel> {
  late double _deviceHeight, _deviceWidth;
  final NewsController newsController = Get.put(NewsController());
  final getStorage = GetStorage();


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) {
      final newsList = newsController.webGeneralNews;

      if (newsList.isEmpty) {
        return const Center(
          child: Text("No news available."),
        );
      }

      return CarouselSlider(
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          height: _deviceHeight * 0.6,
          viewportFraction: 0.28,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
        ),
        items: newsList.map((news) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: _deviceWidth * 0.8,
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.02,
                  vertical: _deviceHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: getStorage.read(AppStrings.themeMode) == "dark"
                      ? AppColors.lightBlack
                      : AppColors.white,
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
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            news.urlToImage ?? '',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: const Image(
                                  image: AssetImage('assets/images/no_news.jpg'),
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
                        child: _newsData(context, news),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    }
    );
  }

  Widget _newsData(context, NewsModel news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        news.title != ""
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _showDialog(context, news),
                  child: news.title!.length > 75
                      ? Text(formatTitleLength(news.title.toString()),
                          style: WebTextStyles.vTitleTextStyle)
                      : Text(news.title.toString(),
                          style: WebTextStyles.vTitleTextStyle),
                ))
            : Container(),
        news.author != ""
            ? Text(news.author.toString(),
                style: WebTextStyles.vAuthorTextStyle)
            : Container(),
        news.publishedAt != ""
            ? Text(news.publishedAt.toString(),
                style: WebTextStyles.vDateTextStyle)
            : Container(),
      ],
    );
  }

  void _showDialog(context, NewsModel news) {
    showDialog(
      context: context,
      builder: (context) => WebIndividualNewsDetailsPopup(
        title: news.title.toString(),
        author: news.author.toString(),
        description: news.description.toString(),
        imageUrl: news.urlToImage!.isNotEmpty
            ? news.urlToImage.toString()
            : "assets/images/no_news.jpg",
        content: news.content.toString(),
        publishedAt: news.publishedAt,
        url: news.url.toString(),
      ),
    );
  }

  String formatTitleLength(String title) {
    return "${title.toString().substring(0, 75)} ...";
  }
}
