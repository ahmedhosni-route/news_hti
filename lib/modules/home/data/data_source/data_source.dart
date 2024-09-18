import '../../../../models/NewsModel.dart';
import '../../../../models/sources_model.dart';

abstract class DataSource {
  Future<NewsModel> getNews(String id);
  Future<SourcesModel> getSources(String catId);
}
