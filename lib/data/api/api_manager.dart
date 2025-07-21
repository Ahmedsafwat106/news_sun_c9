import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_sun_c9/data/model/ArticlesResponse.dart';
import 'package:news_sun_c9/data/model/SourcesResponse.dart';

abstract class ApiManager {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "eaaa53a2d9774a06ae52aa7a9eab7169";
  static const String sourceEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  static Future<List<Source>> getSources(String category) async {
    Uri url = Uri.parse("https://$baseUrl$sourceEndPoint?apiKey=$apiKey& category =$category ");
    Response response = await get(url);
    Map<String, dynamic> json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);

    if (response.statusCode == 200 &&
        sourcesResponse.sources?.isNotEmpty == true) {
      return sourcesResponse.sources!;
    }
    throw Exception(sourcesResponse.message ?? "Unknown error");
  }

  static Future<List<Article>> getArticles(String sourceId) async {
    Uri url = Uri.https(baseUrl, articlesEndPoint, {
      "apiKey": apiKey,
      "sources": sourceId,
    });

    Response serverResponse = await get(url);
    Map<String, dynamic> json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);

    if (serverResponse.statusCode == 200 &&
        articlesResponse.articles?.isNotEmpty == true) {
      return articlesResponse.articles!;
    }

    throw Exception("Something went wrong, please try again later!");
  }
}
