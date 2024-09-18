import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_1am/core/services/cache_helper/cache_helper.dart';

import '../../../models/NewsModel.dart';
import '../../../models/sources_model.dart';

class ApiManger {
  static String baseUrl = "newsapi.org";
  static Future<NewsModel> getNews(String id) async {
    Uri url = Uri.https(baseUrl, "v2/everything", {"sources": id});
    http.Response response = await http
        .get(url, headers: {"x-api-key": "adeec9cc49654e94b646694d29d11ab2"});
    var json = jsonDecode(response.body);
    var data = NewsModel.fromJson(json);
    CacheHelper.saveNews(data);
    return data;
  }

  static Future<SourcesModel> getSources(String catId) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?apiKey=adeec9cc49654e94b646694d29d11ab2&category=$catId");

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    var data = SourcesModel.fromJson(json);
    CacheHelper.saveSources(data);
    return data;
  }
}
