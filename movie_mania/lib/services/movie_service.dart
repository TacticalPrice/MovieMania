import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/models/search.dart';

class MovieService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<Movie>> fetchAllMovies({int page = 1}) async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/movies',
      queryParameters: {'page' : page},
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
    //print(response.data);
    return (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<List<Movie>> fetchMoviesByGenre(int? genre, {required int page}) async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    print(4);
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/movies/filter',
      queryParameters: {
        'genre' : genre
      },
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
    return (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<List<SearchResult>> searchMovies(String query) async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    //print(token);
    print(query);
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/search',
      queryParameters: {
        'query': query,
        //'language': query,
        //'country': query,
        'type' : 'movie',
      },
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
     
    List<dynamic> data = response.data['data'] ?? [];
    print(data);
    List<SearchResult> searchResult = data.map((item) => SearchResult.fromJson(item)).toList();

    return searchResult;
  }
}
