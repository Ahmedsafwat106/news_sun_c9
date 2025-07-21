import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        DetailsScreen.route: (_) => const DetailsScreen(),
        WebviewScreen.route: (_) => const WebviewScreen(),
      },
    );
  }
}
