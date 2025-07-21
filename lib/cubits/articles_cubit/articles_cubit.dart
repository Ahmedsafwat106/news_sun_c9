import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  void loadArticles(String sourceId) async {
    emit(ArticlesLoading());
    try {
      final articles = await ApiManager.getArticles(sourceId);
      emit(ArticlesSuccess(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }
}
