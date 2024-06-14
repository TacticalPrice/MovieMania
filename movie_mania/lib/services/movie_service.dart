import 'package:dio/dio.dart';
import 'package:movie_mania/models/movie.dart';

class MovieService {
  final Dio _dio = Dio();
  Future<List<Movie>> fetchMoviesByGenre(String token, int genreId) async {
    final response = await _dio.get(
        'https://api.thetvdb.com/movies?genres=$genreId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }
}
