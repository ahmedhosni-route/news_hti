import '../../../models/NewsModel.dart';
import '../../../models/sources_model.dart';

abstract class HomeRepo {
  Future<NewsModel> getNews(String id);
  Future<SourcesModel> getSources(String catId);
}
