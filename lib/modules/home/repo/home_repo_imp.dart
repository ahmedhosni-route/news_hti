import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_1am/models/NewsModel.dart';
import 'package:news_1am/models/sources_model.dart';
import 'package:news_1am/modules/home/data/data_source/data_source.dart';
import 'package:news_1am/modules/home/data/data_source/local_data_source.dart';
import 'package:news_1am/modules/home/data/data_source/remote_data_source.dart';
import 'package:news_1am/modules/home/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  late DataSource dataSource;
  @override
  Future<NewsModel> getNews(String id) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      dataSource = RemoteDataSource();
    } else {
      dataSource = LocalDataSource();
    }
    return dataSource.getNews(id);
  }

  @override
  Future<SourcesModel> getSources(String catId) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      dataSource = RemoteDataSource();
    } else {
      dataSource = LocalDataSource();
    }
    return dataSource.getSources(catId);
  }
}
