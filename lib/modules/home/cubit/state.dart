abstract class HomeState {}

class InitState extends HomeState {}

class GetSourcesLoadingState extends HomeState {}

class GetSourcesSuccessState extends HomeState {}

class GetSourcesErrorState extends HomeState {
  String error;
  GetSourcesErrorState(this.error);
}
class GetNewsLoadingState extends HomeState {}

class GetNewsSuccessState extends HomeState {}

class GetNewsErrorState extends HomeState {
  String error;
  GetNewsErrorState(this.error);
}

class ChangeCategoryState extends HomeState{}
class ChangeTapState extends HomeState{}
