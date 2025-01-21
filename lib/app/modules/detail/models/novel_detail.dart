class NovelDetail {
  final int id;
  final String title;
  final String author;
  final String genre;
  final double ratings;
  final String summary;
  final String thumbnailUrl;

  NovelDetail({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.ratings,
    required this.summary,
    required this.thumbnailUrl,
  });

  factory NovelDetail.fromJson(Map<String, dynamic> json) {
    return NovelDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] ?? 'Unknown Title',
      author: json['author'] ?? 'Unknown Author',
      genre: json['genre'] ?? 'Unknown Genre',
      ratings: (json['ratings'] as num?)?.toDouble() ?? 0.0,
      summary: json['summary'] ?? 'No summary available.',
      thumbnailUrl: json['cover']?['formats']?['small']?['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'ratings': ratings,
      'summary': summary,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  String toString() {
    return 'NovelDetail{title: $title, thumbnailUrl: $thumbnailUrl}';
  }
}
