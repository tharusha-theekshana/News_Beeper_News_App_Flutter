import 'package:flutter/material.dart';
import 'package:news_beeper/model/news_model.dart';

import '../../screens/mobile/individual_news_detail_screen.dart';
import '../../utils/mobile/text_styles.dart';


class NewsList extends StatelessWidget {
  List<NewsModel> newsList;
  Axis axis;
  double width;
  double height;
  late double _deviceHeight, _deviceWidth;

  NewsList({required this.newsList,required this.axis,required this.width,required this.height});

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
      scrollDirection: axis,

      itemBuilder: (context, index) {
        var news = newsList[index];

        return  news.title != "[Removed]" ? GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IndividualNewsDetailScreen(news: news);
            },));
          },
          child: Container(
            width: width,
            height: height,
            margin: axis == Axis.horizontal ? EdgeInsets.only(right: _deviceWidth * 0.03,top: _deviceHeight * 0.01) : EdgeInsets.only(top: _deviceHeight * 0.01,bottom: _deviceHeight * 0.01),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: news.urlToImage != null && news.urlToImage!.isNotEmpty
                    ? NetworkImage(news.urlToImage!)
                    : AssetImage('assets/images/no_news.jpg') as ImageProvider,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // Darkens the image slightly
                  BlendMode.darken, // Adjusts how the color filter is applied
                ),
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 100,
                  left: 20,
                  width: _deviceWidth * 0.70,
                  child: news.author!.isNotEmpty ? Text(
                    "By ${news.author}",
                    style: TextStyles.mainPageNewsCardAuthorStyle
                  ) : Container(),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  width: _deviceWidth * 0.74,
                  child: Text(
                    textAlign: TextAlign.start,
                    news.title.toString(),
                    style: TextStyles.mainPageNewsCardTitleStyle
                  ),
                ),
              ],
            ),
          ),
        ) : Container();
    },
    );
  }
}
