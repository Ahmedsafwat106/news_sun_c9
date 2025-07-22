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
        primaryColor: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
          ),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF26C6DA),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1565C0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1565C0)),
          ),
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
