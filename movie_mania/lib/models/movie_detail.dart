class MovieDetail {
  final int id;
  final String name;
  final double score;
  final String year;
  final String image;
  final double runtime;
  final Map<String , dynamic> status;

  MovieDetail({
    required this.score,
    required this.id,
    required this.name,
    required this.year,
    required this.image,
    required this.runtime,
    required this.status,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      score : json['score'],
      id: json['id'],
      name: json['name'],
      year: json['year'],
      image: json['image'],
      runtime : json['runtime'],
      status : json['status']
    );
  }
}
