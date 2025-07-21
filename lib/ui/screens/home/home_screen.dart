import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'package:news_sun_c9/data/model/SourcesResponse.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/news/news_tab.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:news_sun_c9/ui/widgets/loading_widget.dart';
import 'package:news_sun_c9/ui/widgets/error_view.dart';
import 'package:news_sun_c9/ui/widgets/article_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = " ";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;
  String currentSourceId = "";

  @override
  void initState() {
    super.initState();
    currentTab = CategoriesTab(onCategoryClick: onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (currentTab is! CategoriesTab) {
          currentTab = CategoriesTab(onCategoryClick: onCategoryClick);
          setState(() {});
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News APP!"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
          ),
          actions: currentTab is NewsTab && currentSourceId.isNotEmpty
              ? [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: NewsDelegate(sourceId: currentSourceId),
                );
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
              iconSize: 20,
            ),
          ]
              : null,
        ),
        body: currentTab,
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                    child: Text(
                      "New App!",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              buildDrawerRow(Icons.list, "Categories", () {
                currentTab = CategoriesTab(onCategoryClick: onCategoryClick);
                Navigator.pop(context);
                setState(() {});
              }),
              buildDrawerRow(Icons.settings, "Settings", () {
                currentTab = const SettingsTab();
                Navigator.pop(context);
                setState(() {});
              }),
            ],
          ),
        ),
      ),
    );
  }

  void onCategoryClick(CategoryDM categoryDm) async {
    try {
      List<Source> sources = await ApiManager.getSources(categoryDm.id);
      if (sources.isNotEmpty) {
        currentSourceId = sources[0].id ?? "";
        currentTab = NewsTab(
            sourceId: currentSourceId, categoryId: categoryDm.id);
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load sources")),
      );
    }
  }

  Widget buildDrawerRow(IconData iconData, String title, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class NewsDelegate extends SearchDelegate {
  final String sourceId;

  NewsDelegate({required this.sourceId});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22),
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: ApiManager.getArticles(sourceId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ArticleWidget(article: snapshot.data![index]);
            },
          );
        } else if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
