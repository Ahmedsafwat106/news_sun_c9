import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'package:news_sun_c9/ui/screens/webviewscreen/webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = "DetailsScreen";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Article;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title ?? ""),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22),
          ),
        ),
      ),
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (args.urlToImage != null)
            CachedNetworkImage(
              imageUrl: args.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  args.source?['name'] ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff79828B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  args.title ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff42505c),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                    DateTime.now().difference(DateTime.parse(args.publishedAt ?? "")).inHours.toString(),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffA3A3A3),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  args.description ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff42505c),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: ()async{
                   Navigator.pushNamed(context, WebviewScreen.route,arguments: args.url??"");
                  },
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "view this article",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff42505c),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    )
                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
