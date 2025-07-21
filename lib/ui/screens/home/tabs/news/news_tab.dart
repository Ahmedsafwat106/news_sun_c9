import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
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
  List<Source> sources = [];

  @override
  void initState() {
    super.initState();
    loadSources();
  }

  void loadSources() async {
    try {
      sources = await ApiManager.getSources(widget.categoryId);
      setState(() {});
    } catch (e) {
      // handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: sources.length,
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
            tabs: sources.map((source) {
              int index = sources.indexOf(source);
              return buildTabWidget(source.name ?? "", currentTabIndex == index);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: sources
                  .map((source) => NewsList(sourceId: source.id ?? ""))
                  .toList(),
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
