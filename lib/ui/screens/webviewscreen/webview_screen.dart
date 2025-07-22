import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  static const String route = "WebviewScreen";
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final link = ModalRoute.of(context)!.settings.arguments as String;
    final controller = WebViewController()..loadRequest(Uri.parse(link));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          "Web Article",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
