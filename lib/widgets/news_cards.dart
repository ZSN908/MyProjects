import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/ui_screens/artical_details.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle newsArticle;

  const NewsCard({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    // Format the publishedAt date
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final String formattedDate =
        dateFormat.format(DateTime.parse(newsArticle.publishedAt));
    if (newsArticle.title == '[Removed]' ||
        newsArticle.description == '[Removed]') {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticalDetails(newsArticle: newsArticle),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 135,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(newsArticle.urlToImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: newsArticle.urlToImage,
                  placeholder: (context, url) => Center(
                    child: Lottie.asset(
                      'app_assets/animations/mirrorIndicator.json',
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsArticle.title,
                      style: const TextStyle(
                          color: Color.fromARGB(145, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: Text(
                            newsArticle.author,
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: Color.fromARGB(145, 0, 0, 0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(145, 0, 0, 0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewBigCard extends StatelessWidget {
  final NewsArticle newsArticle;

  const NewBigCard({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMMM dd, yyyy');
    final String formattedDate =
        dateFormat.format(DateTime.parse(newsArticle.publishedAt));
    if (newsArticle.title == '[Removed]' ||
        newsArticle.description == '[Removed]') {
      return const SizedBox();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticalDetails(newsArticle: newsArticle),
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                newsArticle.urlToImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: newsArticle.urlToImage,
                          placeholder: (context, url) => Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 57.0),
                              child: Lottie.asset(
                                'app_assets/animations/mirrorIndicator.json',
                                width: 57,
                                height: 57,
                                repeat: true,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 19.0, vertical: 17),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: MediaQuery.of(context).size.height * 0.212,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsArticle.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.7,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Text(
                                  newsArticle.author,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.blue,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.39,
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 13.3,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
