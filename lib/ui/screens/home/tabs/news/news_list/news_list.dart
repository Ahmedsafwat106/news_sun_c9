import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/cubits/articles_cubit/articles_cubit.dart';
import 'package:news_sun_c9/cubits/articles_cubit/articles_state.dart';
import 'package:news_sun_c9/ui/widgets/article_widget.dart';

class NewsList extends StatelessWidget {
  final String sourceId;

  const NewsList({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArticlesCubit()..loadArticles(sourceId),
      child: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticlesError) {
            return Center(child: Text(state.error));
          } else if (state is ArticlesSuccess) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) => ArticleWidget(article: state.articles[index]),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
