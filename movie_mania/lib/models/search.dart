class SearchResult {
  final String id;
  final String name;
  final String overview;
  final String imageUrl;
  final List<String> genres;
  final String country;
  final String primaryLanguage;
  final String year;

  SearchResult({
    required this.id,
    required this.name,
    required this.overview,
    required this.imageUrl,
    required this.genres,
    required this.country,
    required this.primaryLanguage,
    required this.year,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      imageUrl: json['image_url'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      country: json['country'] ?? '',
      primaryLanguage: json['primary_language'] ?? '',
      year: json['year'] ?? '',
    );
  }
}
