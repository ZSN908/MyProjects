import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/models/news_model.dart';

class ArticalDetails extends StatelessWidget {
  final NewsArticle newsArticle;

  const ArticalDetails({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM dd, yyyy')
        .format(DateTime.parse(newsArticle.publishedAt));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text('Details'),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Article Image
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
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
                        width: 50,
                        height: 50,
                        repeat: true,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 50),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
              ),
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(37),
                    topRight: Radius.circular(37),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      newsArticle.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // Author and Published Date
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: Text(
                            newsArticle.author,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Color.fromARGB(195, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color.fromARGB(195, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Divider(height: 24, thickness: 1),
                  const SizedBox(height: 7),
                  // Description/Content
                  Text(
                    newsArticle.description,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 27),
                  const Text(
                    'Content:',
                    style: TextStyle(
                      color: Color.fromARGB(195, 0, 0, 0),
                      fontSize: 13.5,
                      height: 1.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    newsArticle.content,
                    style:
                        const TextStyle(fontSize: 13.5, color: Colors.black54),
                    textAlign: TextAlign.justify,
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
