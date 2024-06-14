import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/models/genre.dart';

class MovieService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<Genre>> fetchGenres() async {
    String? token = await _secureStorage.read(key: 'token');
    final response = await _dio.get(
      'https://api.thetvdb.com/v4/genres',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data['data'] as List)
        .map((genre) => Genre.fromJson(genre))
        .toList();
  }

  Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
    String? token = await _secureStorage.read(key: 'token');
    final response = await _dio.get(
      'https://api.thetvdb.com/v4/genres/$genreId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<List<Movie>> searchMovies(String query, {String? language, String? country}) async {
    String? token = await _secureStorage.read(key: 'token');
    final response = await _dio.get(
      'https://api.thetvdb.com/v4/search',
      queryParameters: {
        'query': query,
        'language': language,
        'country': country,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }
}
