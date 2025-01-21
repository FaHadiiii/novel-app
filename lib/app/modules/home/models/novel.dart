class Novel {
  final int id;
  final String title;
  final String author;
  final double ratings;
  final String thumbnailUrl;

  Novel({
    required this.id,
    required this.title,
    required this.author,
    required this.ratings,
    required this.thumbnailUrl,
  });

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? 'Unknown',
      author: json['author'] as String? ?? 'Unknown',
      ratings: (json['ratings'] as num? ?? 0.0).toDouble(),
      thumbnailUrl: json['cover']['formats']['small']['url'] as String? ?? '',
    );
  }
}
