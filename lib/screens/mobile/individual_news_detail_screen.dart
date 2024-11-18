import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:news_beeper/model/news_model.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/utils/app_strings.dart';
import 'package:news_beeper/utils/mobile/text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/mobile/theme_icon_widget.dart';

class IndividualNewsDetailScreen extends StatefulWidget {
  final NewsModel news;

  IndividualNewsDetailScreen({required this.news});

  @override
  State<IndividualNewsDetailScreen> createState() =>
      _IndividualNewsDetailScreenState();
}

class _IndividualNewsDetailScreenState
    extends State<IndividualNewsDetailScreen> {
  late double _deviceHeight, _deviceWidth;

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(widget.news.publishedAt);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [ThemeIconWidget()],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Stack(
            children: [
              _backgroundImage(),
              _otherDataList(widget.news.description.toString(),
                  widget.news.content.toString(), widget.news.url.toString()),
              _primaryDataList(widget.news.title.toString(), formattedDate,
                  widget.news.author.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return Positioned(
        child: Container(
      height: _deviceHeight * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.news.urlToImage.toString().isNotEmpty &&  widget.news.urlToImage != null
              ? NetworkImage(widget.news.urlToImage.toString())
              : AssetImage('assets/images/no_news.jpg') as ImageProvider,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
    ));
  }

  Widget _primaryDataList(String title, String date, String author) {
    return Positioned(
      top: _deviceHeight * 0.35,
      right: _deviceWidth * 0.1,
      left: _deviceWidth * 0.1,
      child: SingleChildScrollView(
        child: ClipRRect(
          // Ensures the blur doesn't bleed outside the rounded corners
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                // Adjust the blur strength
                child: Container(
                  height: _deviceHeight * 0.18,
                  width: _deviceWidth,
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  // Semi-transparent white to enhance blur
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      date.isNotEmpty
                          ? Text(date, style: TextStyles.dateTextStyle)
                          : Container(),
                      title.isNotEmpty
                          ? Text(_shortenTitle(title),
                              style: TextStyles.titleTextStyle)
                          : Container(),
                      author.isNotEmpty
                          ? Text(
                              _shortenAuthor(author),
                              style: TextStyles.authorTextStyle,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otherDataList(String description, String content, String url) {
    return Positioned(
        top: _deviceHeight * 0.44,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
            height: _deviceHeight * 0.7,
            width: _deviceWidth,
            decoration: BoxDecoration(
                color: storage.read(AppStrings.themeMode) == "light"
                    ? AppColors.white
                    : AppColors.lightBlack,
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
                margin: EdgeInsets.only(top: _deviceHeight * 0.12),
                child: Column(
                  children: [
                    widget.news.description!.isNotEmpty && widget.news.content!.isNotEmpty ?
                    Column(
                      children: [
                        Text(widget.news.description.toString(),
                                style: TextStyles.descriptionTextStyle,
                                textAlign: TextAlign.justify),
                        SizedBox(
                          height: _deviceHeight * 0.03,
                        ),
                        Text(_processContent(widget.news.content.toString()),
                            style: TextStyles.contentTextStyle,
                            textAlign: TextAlign.justify),
                        SizedBox(
                          height: _deviceHeight * 0.04,
                        ),
                      ],
                    ) : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: _deviceHeight * 0.05),
                          child: const Text(
                            " ----- No description & content available -----" , style: TextStyles.descriptionTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: _deviceHeight * 0.03,
                        ),
                      ],
                    ),
                    _newsLink(widget.news.url.toString())
                  ],
                )),
          ),
        ));
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        height: _deviceHeight * 0.05,
        width: _deviceWidth * 0.4,
        decoration: BoxDecoration(
            color: AppColors.crimson,
            borderRadius: BorderRadius.circular(10.0)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Read More ... ',
              style: TextStyles.seeMoreTextStyle
            ),
          ],
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }

  String _processContent(String content) {
    String cleanedContent = content.replaceAll(RegExp(r"\[\+\d+ chars\]"), '');
    int cleanContentLength = cleanedContent.length;

    cleanedContent = cleanedContent.substring(0, cleanContentLength);

    return cleanedContent;
  }

  String _shortenTitle(String title) {
    return title.length > 120 ? "${title.substring(0, 120)}..." : title;
  }

  String _shortenAuthor(String author) {
    return author.length > 50
        ? "By ${author.substring(0, 120)}..."
        : "By ${author}";
  }
}
