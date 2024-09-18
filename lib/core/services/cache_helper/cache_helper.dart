import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:news_1am/models/NewsModel.dart';
import 'package:news_1am/models/sources_model.dart';
import 'package:path_provider/path_provider.dart';

class CacheHelper {
  static Future<void> saveSources(SourcesModel sourcesModel) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    print(appDocumentsDir.path);
    final collection = await BoxCollection.open(
      'News', // Name of your database
      {
        'Sources',
      }, // Names of your boxes
      path: appDocumentsDir
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    final sourcesBox =
        await collection.openBox<Map<String, dynamic>>('Sources');
    await sourcesBox.put("sourcesModel", sourcesModel.toJson());
  }

  static Future<SourcesModel> getSources() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'News', // Name of your database
      {
        'Sources',
      }, // Names of your boxes
      path: appDocumentsDir
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    final sourcesBox =
        await collection.openBox<Map<dynamic, dynamic>>('Sources');
    var json = await sourcesBox.get("sourcesModel");
    return SourcesModel.fromJson(json);
  }

  static Future<void> saveNews(NewsModel newsModel) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    print(appDocumentsDir.path);
    final collection = await BoxCollection.open(
      'News', // Name of your database
      {
        'news',
      }, // Names of your boxes
      path: appDocumentsDir
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    final sourcesBox = await collection.openBox<Map<String, dynamic>>('news');
    await sourcesBox.put("newsModel", newsModel.toJson());
  }

  static Future<NewsModel> getNews() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'News', // Name of your database
      {
        'news',
      }, // Names of your boxes
      path: appDocumentsDir
          .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    final sourcesBox = await collection.openBox<Map<dynamic, dynamic>>('news');
    var json = await sourcesBox.get("newsModel");
    return NewsModel.fromJson(json);
  }
}
