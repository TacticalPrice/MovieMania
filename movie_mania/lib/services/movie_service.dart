import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/models/movie_detail.dart';
import 'package:movie_mania/models/search.dart';

class MovieService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<dynamic>> fetchAllMovies({int page = 1}) async {
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
    final List<dynamic> data = response.data['data'];
    return data;
    // (response.data['data'] as List)
    //     .map((movie) => Movie.fromJson(movie))
    //     .toList();
  }

  Future<List<dynamic>>fetchMoviesByGenre(int? genre, {required int page}) async {
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

    final List<dynamic> data = response.data['data'];
    return data;
    // (response.data['data'] as List)
    //     .map((movie) => Movie.fromJson(movie))
    //     .toList();
  }

  Future<List<dynamic>> searchMovies(String query , String language , String country , int offset ,int limit) async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    print(query);
    print(query);
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/search',
      queryParameters: {
        'query': query,
        'language': language,
        'country': country,
        'type' : 'movie',
        'offset' : offset,
        'limit' : limit,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );

    print('response');
     
    List<dynamic> data = response.data['data'] ?? [];
    print(data);
    List<SearchResult> searchResult = data.map((item) => SearchResult.fromJson(item)).toList();

    return data;
  }

  Future<Map<String , dynamic>> movieDetail(String movieId) async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    print(movieId);
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/movies/$movieId/extended',
      queryParameters: {
        'meta' : 'translations',
        'short' : false,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );

    //print(response.data['data']);
     
    final Map<String, dynamic> data = response.data['data'];
    return data;
  }


}
