class MovieStatus {
  final int id;
  final String name;
  final String recordType;
  final bool keepUpdated;

  MovieStatus({
    required this.id,
    required this.name,
    required this.recordType,
    required this.keepUpdated,
  });

  factory MovieStatus.fromJson(Map<String, dynamic> json) {
    return MovieStatus(
      id: json['id'],
      name: json['name'],
      recordType: json['recordType'],
      keepUpdated: json['keepUpdated'],
    );
  }
}

class Movie {
  final int id;
  final String image;
  final String name;
  final double score;
  final String year;
  final MovieStatus status;

  Movie({required this.status, required this.id, required this.image, required this.name, required this.score, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      image: json['image'] != null && json['image'].isNotEmpty
             ? 'https://artworks.thetvdb.com${json['image']}' : '',
      name: json['name'] ?? '',
      score: json['score'].toDouble() ?? 0.0,
      year: json['year'] ?? '',
      status : MovieStatus.fromJson(json['status']),
    );
  }

  Map<String , dynamic> toJson() {
    return {
      'id' : id,
      'image' : image,
      'name' : name,
      'score' : score,
      'year' : year,
      'status' : status
    };
  }
}


  

