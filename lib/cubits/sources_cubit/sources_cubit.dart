import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/SourcesResponse.dart';
import 'sources_state.dart';

class SourcesCubit extends Cubit<SourcesState> {
  SourcesCubit() : super(SourcesInitial());

  void loadSources(String categoryId) async {
    emit(SourcesLoading());
    try {
      final sources = await ApiManager.getSources(categoryId);
      emit(SourcesSuccess(sources));
    } catch (e) {
      emit(SourcesError(e.toString()));
    }
  }
}
