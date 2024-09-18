import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_1am/modules/home/cubit/state.dart';
import 'package:http/http.dart' as http;
import 'package:news_1am/modules/home/repo/home_repo.dart';
import 'package:news_1am/modules/home/repo/home_repo_imp.dart';

import '../../../models/NewsModel.dart';
import '../../../models/category_data.dart';
import '../../../models/sources_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  SourcesModel? sourcesModel;
  NewsModel? newsModel;
  HomeRepo homeRepo = HomeRepoImp();
  int selectedIndex = 0;
  List<Sources> sources = [];
  List<Articles> articles = [];
  CategoryData? categoryData;

  onTapCategory(cat) {
    categoryData = cat;
    emit(ChangeCategoryState());
  }

  tabClicked(value) async {
    selectedIndex = value;
    getNews();
    emit(ChangeTapState());
  }

  resetData() {
    selectedIndex = 0;
    sources = [];
    articles = [];
    categoryData = null;
    emit(ChangeCategoryState());
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());

    try {
      sourcesModel = await homeRepo.getSources(categoryData!.id);
      sources = sourcesModel?.sources ?? [];
      emit(GetSourcesSuccessState());
      getNews();
    } catch (e) {
      emit(GetSourcesErrorState(e.toString()));
    }
  }

  Future<void> getNews() async {
    emit(GetNewsLoadingState());
    try {
      newsModel = await homeRepo.getNews(sources[selectedIndex].id!);
      articles = newsModel?.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState(e.toString()));
    }
  }
}
