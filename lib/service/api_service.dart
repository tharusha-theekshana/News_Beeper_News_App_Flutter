import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_beeper/environment/env_data.dart';
import 'package:news_beeper/model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetConnect implements GetxService{

  // Get headlines API call
  Future<List<NewsModel>> getHeadLines() async {
    try {
      final response = await http.get(Uri.parse("${EnvData.baseUrl}/top-headlines?country=us&apiKey=${EnvData.apiKey}"));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        return news;
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      print("Error fetching headlines: $e");
      return [];
    }
  }

  // Get news category wise API call
  Future<List<NewsModel>> getCategoryNews({required String category}) async {
    try {
      final response = await http.get(Uri.parse("${EnvData.baseUrl}/top-headlines?country=us&category=$category&apiKey=${EnvData.apiKey}"));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        return news;
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      print("Error fetching headlines: $e");
      return [];
    }
  }

  // Get news some topics wise API call
  Future<List<NewsModel>> getNewsForFamousTopics({required String topic}) async {
    try {
      topic = topic.toLowerCase();
      final response = await http.get(Uri.parse(
        "${EnvData.baseUrl}/everything?q=$topic&apiKey=${EnvData.apiKey}",
      ));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        return news;
      } else {
        throw Exception('Failed to load news for topic');
      }
    } catch (e) {
      print("Error fetching news for topic: $e");
      return [];
    }
  }

  // Get news with search API call
  Future<List<NewsModel>> getSearchNews({required String searchText}) async {
    try {
      final response = await http.get(Uri.parse(
        "${EnvData.baseUrl}/everything?q=$searchText&apiKey=${EnvData.apiKey}",
      ));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        return news;
      } else {
        throw Exception('Failed to load search news');
      }
    } catch (e) {
      print("Error fetching search news: $e");
      return [];
    }
  }

}