import 'package:flutter/material.dart';
import 'package:news_beeper/utils/web/web_text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/app_colors.dart';

class WebIndividualNewsDetailsPopup extends StatelessWidget  {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String content;
  final DateTime publishedAt;
  final String url;

  WebIndividualNewsDetailsPopup({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.publishedAt,
    required this.url,
  }) : super(key: key);

  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Dialog(
      child: Container(
        height: _deviceHeight * 0.6,
        padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01 ,horizontal: _deviceWidth * 0.02),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.03),
                  child: Text(
                    title,
                    style: WebTextStyles.titleTextStyle,
                  ),
                ),
                SizedBox(
                  height: _deviceHeight * 0.3,
                  width: _deviceWidth * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      imageUrl,
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
                        return const Image(
                          image: AssetImage('assets/images/no_news.jpg'),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _newsDetailsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _newsDetailsWidget() {
    return Container(
      width: _deviceWidth * 0.3,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            author,
            style: WebTextStyles.authorTextStyle,
          ),
          Text(
            publishedAt.toString(),
            style: WebTextStyles.dateTextStyle,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: WebTextStyles.descriptionTextStyle,
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: WebTextStyles.contentTextStyle,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          _newsLink(url),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        width: _deviceWidth * 0.05,
        height: _deviceHeight * 0.04,
        decoration: BoxDecoration(
          color: AppColors.crimson,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
          child: Text(
            'Read More ...',
            style: WebTextStyles.seeMoreTextStyle,
          ),
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }
}
