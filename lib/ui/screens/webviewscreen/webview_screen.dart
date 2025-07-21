import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScreen extends StatelessWidget {
  static const String route = "WebviewScreen";
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var link = ModalRoute.of(context)?.settings.arguments as String;
    WebViewController controller = WebViewController()..loadRequest(Uri.parse(link));
    return Scaffold(
      appBar:  AppBar(
        title: Text("Web View",style: TextStyle(
          fontSize: 15,
        ),),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22),
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
