import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/web/web_individual_news_details_popup.dart';

import '../../model/news_model.dart';
import '../../utils/mobile/text_styles.dart';

class WebNewsList extends StatelessWidget {
  List<NewsModel> newsList;
  double width;
  double height;
  late double _deviceHeight, _deviceWidth;

  WebNewsList(
      {required this.newsList, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    return ListView.builder(
      itemCount: newsList.length,
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) {
        var news = newsList[index];

        return news.title != "[Removed]" ? MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                _showDialog(context, news);
              },
              child: Container(
                margin: EdgeInsets.only(right: _deviceWidth * 0.005),
                child: Stack(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
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
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    (loadingProgress
                                        .expectedTotalBytes ?? 1)
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
                                image: AssetImage(
                                    'assets/images/no_news.jpg'),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        // Darkens the image slightly
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 20,
                      width: _deviceWidth * 0.70,
                      child: news.author!.isNotEmpty
                          ? Text(
                        "By ${news.author}",
                        style: TextStyles.mainPageNewsCardAuthorStyle,
                      )
                          : Container(),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      width: width * 0.9,
                      child: Text(
                        textAlign: TextAlign.start,
                        news.title!.length > 50 ? formatTitleLength(news.title.toString()) : news.title.toString(),
                        style: TextStyles.mainPageNewsCardTitleStyle,
                      ),
                    ),
                  ],
                ),
              )
          ),
        ) : Container();
      },
    );
  }

  void _showDialog(context,NewsModel news){
    showDialog(
      context: context,
      builder: (context) => WebIndividualNewsDetailsPopup(
        title: news.title.toString(),
        author: news.author.toString(),
        description: news.description.toString(),
        imageUrl: news.urlToImage!.isNotEmpty ? news.urlToImage.toString() : "assets/images/no_news.jpg",
        content: news.content.toString(),
        publishedAt: news.publishedAt,
        url: news.url.toString(),
      ),
    );
  }

  String formatTitleLength(String title){
    return "${title.toString().substring(0,50)} ...";
  }
}
