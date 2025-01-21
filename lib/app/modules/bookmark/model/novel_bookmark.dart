class NovelBookmark {
  final int id;
  final String title;
  final String author;
  final double ratings;
  final String thumbnailUrl;

  NovelBookmark({
    required this.id,
    required this.title,
    required this.author,
    required this.ratings,
    required this.thumbnailUrl,
  });

  factory NovelBookmark.fromJson(Map<String, dynamic> json) {
    return NovelBookmark(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      ratings: (json['ratings'] as num).toDouble(),
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'NovelBookmark{id: $id, title: $title, author: $author, ratings: $ratings, thumbnailUrl: $thumbnailUrl}';
  }
}
