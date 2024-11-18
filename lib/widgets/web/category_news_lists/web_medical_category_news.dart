import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../controller/news_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/news_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/web/web_text_styles.dart';

class WebMedicalCategoryNews extends StatefulWidget {
  const WebMedicalCategoryNews({super.key});

  @override
  State<WebMedicalCategoryNews> createState() => _WebMedicalCategoryNewsState();
}

class _WebMedicalCategoryNewsState extends State<WebMedicalCategoryNews> {
  late double _deviceHeight, _deviceWidth;
  final NewsController newsController = Get.put(NewsController());
  late Future<List<NewsModel>> healthNewsList;

  @override
  void initState() {
    super.initState();
    // Fetch health news data
    healthNewsList =
        newsController.getCategoryNews(category: AppStrings.health);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<NewsModel>>(
      future: healthNewsList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.crimson),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news available'));
        } else {
          final List<NewsModel> healthNews = snapshot.data!;

          return CarouselSlider(
            options: CarouselOptions(
              height: _deviceHeight * 0.6,
              scrollPhysics: BouncingScrollPhysics(),
              autoPlay: true,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
            ),
            items: healthNews.map((news) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: _deviceWidth,
                    height: _deviceHeight * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            news.urlToImage.toString(),
                            width: _deviceWidth,
                            height: _deviceHeight * 0.6,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback asset image on error
                              return Image.asset(
                                "assets/images/no_news.jpg",
                                width: _deviceWidth,
                                height: _deviceHeight * 0.6,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        // Dark overlay to darken the image
                        Container(
                          width: _deviceWidth,
                          height: _deviceHeight * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(flex: 6, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.bottomRight,
                                margin: EdgeInsets.symmetric(
                                  vertical: _deviceHeight * 0.02,
                                  horizontal: _deviceWidth * 0.01,
                                ),
                                child: _newsData(news),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _newsData(NewsModel news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        news.title!.isNotEmpty
            ? Text(news.title.toString(), style: WebTextStyles.mTitleTextStyle)
            : Container(),
        SizedBox(height: _deviceHeight * 0.05),
        news.description!.isNotEmpty
            ? Text(news.description.toString(),
                style: WebTextStyles.mDescriptionTextStyle)
            : Container(),
        SizedBox(height: _deviceHeight * 0.05),
        _newsLink(news.url.toString()),
      ],
    );
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        width: _deviceWidth * 0.05,
        height: _deviceHeight * 0.05,
        decoration: BoxDecoration(
            color: AppColors.crimson,
            borderRadius: BorderRadius.circular(10.0)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Read More ... ', style: WebTextStyles.seeMoreTextStyle),
          ],
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }
}
