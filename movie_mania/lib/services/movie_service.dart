import 'package:dio/dio.dart';
import 'package:movie_mania/models/search.dart';
import 'package:movie_mania/services/dio_service.dart';

class MovieService {

  final Dio dio = Dio();

  final DioService dioService  = DioService();

  Future<List<dynamic>> fetchAllMovies({int page = 1}) async {
    final response = await dioService.dio.get('/v4/movies',
      queryParameters: {'page' : page},
    );
    final List<dynamic> data = response.data['data'];
    return data;
  }

  Future<List<dynamic>>fetchMoviesByGenre(int? genre, {required int page}) async {
    print(4);
    final response = await dioService.dio.get('/v4/movies/filter',
      queryParameters: {
        'genre' : genre
      },
    );

    final List<dynamic> data = response.data['data'];
    return data;
  }

  Future<List<dynamic>> searchMovies(String query , String language , String country , int offset ,int limit) async {
    final response = await dioService.dio.get('/v4/search',
      queryParameters: {
        'query': query,
        'language': language,
        'country': country,
        'type' : 'movie',
        'offset' : offset,
        'limit' : limit,
      },
    );

    print('response');
     
    List<dynamic> data = response.data['data'] ?? [];
    print(data);
    List<SearchResult> searchResult = data.map((item) => SearchResult.fromJson(item)).toList();

    return data;
  }

  Future<Map<String , dynamic>> movieDetail(String movieId) async {
    final response = await dioService.dio.get('/v4/movies/$movieId/extended',
      queryParameters: {
        'meta' : 'translations',
        'short' : false,
      },
    );

    //print(response.data['data']);
     
    final Map<String, dynamic> data = response.data['data'];
    return data;
  }


}
