import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/models/news_model.dart';

final countryProvider = StateProvider<String>((ref) => 'us');
final categoryProvider = StateProvider<String>((ref) => 'general');
final authorProvider = StateProvider<String>((ref) => 'bbc-news');

final newsProvider = FutureProvider<List<NewsArticle>>((ref) async {
  final country = ref.watch(countryProvider);
  final category = ref.watch(categoryProvider);
  // final author = ref.watch(authorProvider);

  final apiService = ApiService();

  final newsByCategoryAndCountry =
      await apiService.fetchNews(category, country);

  // final newsBySource = await apiService.fetchNewsBySource(author);

  // final combinedNews = [
  //   ...newsByCategoryAndCountry.map<NewsArticle>(
  //     (article) => NewsArticle.fromJson(article),
  //   ),
  //   ...newsBySource.map<NewsArticle>(
  //     (article) => NewsArticle.fromJson(article),
  //   ),
  // ];

  // return combinedNews;
  return newsByCategoryAndCountry
      .map<NewsArticle>((article) => NewsArticle.fromJson(article))
      .toList();
});

final newsBySourceProvider = FutureProvider<List<NewsArticle>>((ref) async {
  final author = ref.watch(authorProvider);

  final apiService = ApiService();
  final newsData = await apiService.fetchNewsBySource(author);

  return newsData
      .map<NewsArticle>((article) => NewsArticle.fromJson(article))
      .toList();
});
