import 'package:news_1am/models/NewsModel.dart';
import 'package:news_1am/models/sources_model.dart';
import 'package:news_1am/modules/home/data/data_source/data_source.dart';

import '../../../../core/services/Apis/api_manger.dart';

class RemoteDataSource implements DataSource {
  @override
  Future<NewsModel> getNews(String id) async {
    return await ApiManger.getNews(id);
  }

  @override
  Future<SourcesModel> getSources(String catId) async {
    return await ApiManger.getSources(catId);
  }
}
