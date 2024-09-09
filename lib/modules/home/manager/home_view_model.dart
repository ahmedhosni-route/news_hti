import 'package:flutter/material.dart';
import 'package:news_1am/core/base.dart';
import 'package:news_1am/models/NewsModel.dart';
import 'package:news_1am/models/category_data.dart';
import 'package:news_1am/models/sources_model.dart';
import 'package:news_1am/modules/home/manager/home_connector.dart';

import '../../../core/services/Apis/api_manger.dart';

class HomeViewModel extends BaseViewModel {

  int selectedIndex = 0;
  List<Sources> sources = [];
  List<Articles> articles = [];
  CategoryData? categoryData;
  onTapCategory(cat) {
    categoryData = cat;
    notifyListeners();
  }

  getSources() async {
    connector!.showLoading();
    notifyListeners();

    var data = await ApiManger.getSources(categoryData!.id);
    sources = data.sources ?? [];
    await getNews();
    connector!.hideLoading();
    notifyListeners();


  }

  getNews() async {
    var data = await ApiManger.getNews(sources[selectedIndex].id ?? "");
    articles = data.articles ?? [];
    notifyListeners();
  }

  tabClicked(value)async {
    selectedIndex = value;
     getNews();
    notifyListeners();
  }

  resetData(){
    selectedIndex = 0;
    sources = [];
    articles = [];
    categoryData = null;
    notifyListeners();
  }
}
