import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../utils/mykey.dart';

class ApiService {
  final String _baseUrl = "https://newsapi.org/v2/top-headlines";
  final String _apiKey =
      ApiKeys.newsApiKey; // use your key instead of "ApiKeys.newsApiKey"

  Future<List<Map<String, dynamic>>> fetchNews(
      String category, String country) async {
    log('Fetching news');
    final url = Uri.parse(
        "$_baseUrl?country=$country&category=$category&apiKey=$_apiKey");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('Data fetched: ${response.body}');
      return List<Map<String, dynamic>>.from(data['articles']);
    } else {
      log('Error occurred');
      throw Exception("Failed to fetch news");
    }
  }

  // Fetch news by a specific source (like BBC, etc.).
  Future<List<Map<String, dynamic>>> fetchNewsBySource(String source) async {
    log('Fetching news by source');
    final url = Uri.parse("$_baseUrl?sources=$source&apiKey=$_apiKey");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('Data fetched: ${response.body}');
      return List<Map<String, dynamic>>.from(data['articles']);
    } else {
      log('Error occurred');
      throw Exception("Failed to fetch news by source");
    }
  }
}
