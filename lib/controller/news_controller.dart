import 'package:get/get.dart';
import 'package:news_beeper/model/news_model.dart';
import 'package:news_beeper/service/api_service.dart';

class NewsController extends GetxController{

  ApiService apiService = ApiService();

  List<NewsModel> latestNews = [];
  List<NewsModel> newsList = [];
  List<NewsModel> famousTopicNews = [];
  List<NewsModel> searchNews = [];

  // News list for web platform
  List<NewsModel> webBusinessNews = [];
  List<NewsModel> webEntertainmentNews = [];
  List<NewsModel> webGeneralNews = [];
  List<NewsModel> webHealthNews = [];
  List<NewsModel> webScienceNews = [];
  List<NewsModel> webSportsNews = [];
  List<NewsModel> webTechnologyNews = [];

  var isLoading = false.obs;

  // Get latest news
  Future<void> getLatestNews() async {
    try{
      List<NewsModel> fetchedNewsList = await apiService.getHeadLines();
      latestNews = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();
    }catch(e){
      print(e.toString());
    }
  }

  // Get category news
  Future<List<NewsModel>> getCategoryNews({required String category}) async {
    try{
      List<NewsModel> fetchedNewsList  = await apiService.getCategoryNews(category: category);
      newsList = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();
      return newsList;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  // Get news for famous topics (Mobile only)
  Future<List<NewsModel>> getNewsForFamousTopics({required String topic}) async {
    try{

      List<NewsModel> fetchedNewsList  = await apiService.getNewsForFamousTopics(topic: topic);
      famousTopicNews = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();
      return famousTopicNews;

    }catch(e){
      print(e.toString());
      return [];
    }
  }

  // Get news for search results
  Future<List<NewsModel>> getSearchNews({required String searchText}) async {
    try{
      isLoading(true);

      List<NewsModel> fetchedNewsList = await apiService.getSearchNews(searchText: searchText);
      searchNews = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();

      isLoading(false);
      return searchNews;

    }catch(e){
      print(e.toString());
      return [];
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getLatestNews();
    super.onInit();
  }

}