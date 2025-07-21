import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/cubits/sources_cubit/sources_cubit.dart';
import 'package:news_sun_c9/cubits/sources_cubit/sources_state.dart';
import 'package:news_sun_c9/data/model/SourcesResponse.dart';
import 'news_list/news_list.dart';

class NewsTab extends StatefulWidget {
  final String sourceId;
  final String categoryId;

  const NewsTab({super.key, required this.sourceId, required this.categoryId});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SourcesCubit>().loadSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcesCubit, SourcesState>(
      builder: (context, state) {
        if (state is SourcesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SourcesError) {
          return Center(child: Text(state.error));
        } else if (state is SourcesSuccess) {
          return buildTabs(state.sources);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildTabs(List<Source> list) {
    return DefaultTabController(
      length: list.length,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            onTap: (index) {
              currentTabIndex = index;
              setState(() {});
            },
            tabs: list.map((source) {
              int index = list.indexOf(source);
              return buildTabWidget(source.name ?? "", currentTabIndex == index);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: list.map((source) => NewsList(sourceId: source.id!)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabWidget(String name, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.blue),
      ),
      child: Text(
        name,
        style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
      ),
    );
  }
}
