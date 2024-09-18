import 'package:news_1am/modules/home/data/data_source/data_source.dart';

import '../../../../core/services/cache_helper/cache_helper.dart';
import '../../../../models/NewsModel.dart';
import '../../../../models/sources_model.dart';

class LocalDataSource implements DataSource {
  @override
  Future<NewsModel> getNews(String id) {
    return CacheHelper.getNews();
  }

  @override
  Future<SourcesModel> getSources(String catId) {
    return CacheHelper.getSources();
  }
}
