import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void search(String sourceId) async {
    emit(SearchLoading());
    try {
      final articles = await ApiManager.getArticles(sourceId);
      emit(SearchSuccess(articles));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
