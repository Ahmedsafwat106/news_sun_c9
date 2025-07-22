import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = "DetailsScreen";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Article;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.title ?? "",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
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
                      color: const Color(0xFF79828B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    args.title ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${DateTime.now().difference(DateTime.parse(args.publishedAt!)).inHours} hours ago",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA3A3A3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    args.description ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF42505C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/WebviewScreen",
                          arguments: args.url!);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "View Full Article",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1565C0),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_right,
                          color: Color(0xFF1565C0),
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
