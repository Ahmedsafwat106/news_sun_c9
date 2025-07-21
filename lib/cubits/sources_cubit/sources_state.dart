import 'package:news_sun_c9/data/model/SourcesResponse.dart';

abstract class SourcesState {}

class SourcesInitial extends SourcesState {}

class SourcesLoading extends SourcesState {}

class SourcesSuccess extends SourcesState {
  final List<Source> sources;
  SourcesSuccess(this.sources);
}

class SourcesError extends SourcesState {
  final String error;
  SourcesError(this.error);
}
