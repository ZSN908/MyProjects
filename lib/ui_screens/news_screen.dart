import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/ui_screens/category_screen.dart';
import 'package:news_app/widgets/news_cards.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.circle_grid_3x3_fill,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesScreen()),
            );
          },
        ),
        title: const Center(child: Text('News')),
        actions: [
          PopupMenuButton<String>(
            // color: Colors.white,
            onSelected: (value) {
              ref.read(authorProvider.notifier).state = value;
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'bbc-news',
                  child: Text(
                    ' BBC News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'espn',
                  child: Text(
                    ' ESPN News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'al-jazeera-english',
                  child: Text(
                    ' Al-Jazeera News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'cnn',
                  child: Text(
                    ' CNN News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'nbc-news',
                  child: Text(
                    ' NBC News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'ary-news',
                  child: Text(
                    ' Ary News',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'financial-post',
                  child: Text(
                    ' Financial',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ref.watch(newsProvider).when(
                data: (articles) {
                  if (articles.isEmpty) {
                    return const Center(child: Text('No news available.'));
                  }
                  return Column(
                    children: [
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.45 + 5),
                      Expanded(
                        child: ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return NewsCard(newsArticle: articles[index]);
                          },
                        ),
                      ),
                    ],
                  );
                },
                loading: () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 17),
                    Center(
                      child: Lottie.asset(
                        'app_assets/animations/threeDancingBlueBalls.json',
                        width: 50,
                        height: 50,
                        repeat: true,
                      ),
                    ),
                  ],
                ),
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.only(
                    top: 57,
                  ),
                  child: Center(
                      child: Text(
                    'Error2: $error',
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
          ref.watch(newsBySourceProvider).when(
                data: (sourceArticles) {
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sourceArticles.length > 7
                                ? 7
                                : sourceArticles.length,
                            itemBuilder: (context, index) {
                              return NewBigCard(
                                  newsArticle: sourceArticles[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                loading: () => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Center(
                    child: Lottie.asset(
                      'app_assets/animations/threeDancingBlueBalls.json',
                      width: 57,
                      height: 57,
                      repeat: true,
                    ),
                  ),
                ),
                error: (error, stack) => Positioned(
                    top: 70,
                    child: Center(
                        child: Text(
                      'Error1: $error',
                      textAlign: TextAlign.center,
                    ))),
              ),
        ],
      ),
    );
  }
}
