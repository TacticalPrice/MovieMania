import 'package:dio/dio.dart';
import 'package:movie_mania/models/genre.dart';

class GenreService {
  final Dio _dio = Dio();

  Future<List<Genre>> fetchingGenres(String token) async {
    final response = await _dio.get(
      'https://api.thetvdb.com/genres',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data['data'] as List)
        .map((genre) => Genre.fromJson(genre))
        .toList();
  }
}
