class Movie {
  final int id;
  final String title;
  final String poster;
  final String description;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        poster: json['poster'],
        description: json['decription']);
  }

  Map<String , dynamic> toJson() {
    return {
      'id' : id,
      'title' : title,
      'poster' : poster,
      'description' : description,
    };
  }
}
