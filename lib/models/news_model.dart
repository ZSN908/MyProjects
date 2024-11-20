class NewsArticle {
  final String title;
  final String author;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String sourceName;

  NewsArticle({
    required this.title,
    required this.author,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "No title",
      author: json['author'] ?? "Unknown",
      description: json['description'] ?? "No description",
      content: json['content'] ?? '[No content]',
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      sourceName: json['source']['name'] ?? "Unknown",
    );
  }
}
