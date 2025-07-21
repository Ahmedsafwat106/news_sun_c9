import 'package:news_sun_c9/data/model/ArticlesResponse.dart';

abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  final List<Article> articles;
  ArticlesSuccess(this.articles);
}

class ArticlesError extends ArticlesState {
  final String error;
  ArticlesError(this.error);
}
