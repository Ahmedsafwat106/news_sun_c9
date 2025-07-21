import 'package:news_sun_c9/data/model/ArticlesResponse.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Article> articles;
  SearchSuccess(this.articles);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
