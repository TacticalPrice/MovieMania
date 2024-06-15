

class Movie {
  final int id;
  final String image;
  final String name;
  final double score;
  final String year;

  Movie({required this.id, required this.image, required this.name, required this.score, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      image: json['image'] != null && json['image'].isNotEmpty
             ? 'https://artworks.thetvdb.com${json['image']}' : '',
      name: json['name'] ?? '',
      score: json['score'].toDouble() ?? 0.0,
      year: json['year'] ?? '',
    );
  }

  Map<String , dynamic> toJson() {
    return {
      'id' : id,
      'image' : image,
      'name' : name,
      'score' : score,
      'year' : year,
    };
  }
}


  

