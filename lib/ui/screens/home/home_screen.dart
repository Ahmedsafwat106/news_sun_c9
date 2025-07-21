import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/cubits/sources_cubit/sources_cubit.dart';
import 'package:news_sun_c9/cubits/search_cubit/search_cubit.dart';
import 'package:news_sun_c9/cubits/search_cubit/search_state.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'package:news_sun_c9/data/model/SourcesResponse.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/news/news_tab.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:news_sun_c9/ui/widgets/article_widget.dart';
import 'package:news_sun_c9/ui/widgets/error_view.dart';
import 'package:news_sun_c9/ui/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = " ";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;
  String currentSourceId = "";
  bool isNewsTabActive = false;

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
          isNewsTabActive = false;
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
          actions: isNewsTabActive && currentSourceId.isNotEmpty
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
                decoration: BoxDecoration(color: Color(0xFF436EA0)),
                child: Center(child: Text("New App!")),
              ),
              buildDrawerRow(Icons.list, "Categories", () {
                currentTab = CategoriesTab(onCategoryClick: onCategoryClick);
                isNewsTabActive = false;
                Navigator.pop(context);
                setState(() {});
              }),
              const SizedBox(height: 16),
              buildDrawerRow(Icons.settings, "Settings", () {
                currentTab = const SettingsTab();
                isNewsTabActive = false;
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
        isNewsTabActive = true;
        currentTab = BlocProvider(
          create: (_) => SourcesCubit()..loadSources(categoryDm.id),
          child: NewsTab(sourceId: currentSourceId, categoryId: categoryDm.id),
        );
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
      onTap: () => onClick(),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(iconData),
          const SizedBox(width: 4),
          Text(title),
        ],
      ),
    );
  }
}

class NewsDelegate extends SearchDelegate {
  final String sourceId;

  NewsDelegate({required this.sourceId});

  @override
  List<Widget>? buildActions(BuildContext context) => [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit()..search(sourceId),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const LoadingWidget();
          } else if (state is SearchSuccess) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) =>
                  ArticleWidget(article: state.articles[index]),
            );
          } else if (state is SearchError) {
            return ErrorView(message: state.error);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => const SizedBox();
}
