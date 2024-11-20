import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/providers/news_provider.dart'; // Import the news provider
import 'package:news_app/widgets/news_cards.dart'; // Import the news card widget

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = [
      'General',
      'Entertainment',
      'Health',
      'Sports',
      'Business',
      'Science',
      'Technology'
    ];

    final selectedCategory = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Horizontal list of category buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: categories[index] == 'Technology' ? 5.0 : 0.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(categoryProvider.notifier).state =
                            categories[index].toLowerCase();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == categories[index].toLowerCase()
                                ? Colors.blue
                                : Colors.grey,
                      ),
                      child: Text(
                        categories[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Display the news based on the selected category
          Expanded(
            child: ref.watch(newsProvider).when(
                  data: (articles) {
                    if (articles.isEmpty) {
                      return const Center(child: Text('No news available.'));
                    }
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return NewsCard(newsArticle: articles[index]);
                      },
                    );
                  },
                  loading: () => Center(
                    child: Lottie.asset(
                      'app_assets/animations/threeDancingBlueBalls.json',
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
                  ),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
          ),
        ],
      ),
    );
  }
}
