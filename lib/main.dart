import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c9/cubits/articles_cubit/articles_cubit.dart';
import 'package:news_sun_c9/cubits/search_cubit/search_cubit.dart';
import 'package:news_sun_c9/cubits/sources_cubit/sources_cubit.dart';
import 'package:news_sun_c9/ui/screens/home/home_screen.dart';
import 'package:news_sun_c9/ui/screens/details/details_screen.dart';
import 'package:news_sun_c9/ui/screens/webviewscreen/webview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F6F9),
        primaryColor: const Color(0xFF4F1A7E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF436EA0),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
          ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        DetailsScreen.route: (_) => const DetailsScreen(),
        WebviewScreen.route: (_) => const WebviewScreen(),
      },
    );
  }
}
