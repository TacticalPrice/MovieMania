class MovieDetail {
  final int id;
  final String name;
  //final String? overview;
  final String year;
  final String image;
  // Add other fields as necessary

  MovieDetail({
    required this.id,
    required this.name,
    //this.overview,
    required this.year,
    required this.image,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      name: json['name'],
      //overview: json['overview'],
      year: json['year'],
      image: json['image'],
      // Initialize other fields as necessary
    );
  }
}
