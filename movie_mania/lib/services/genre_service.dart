import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/models/genre.dart';

class GenreService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();


  Future<List<Genre>> fetchingGenres() async {
    String? token = await _secureStorage.read(key: 'token');
    print(2);
    final response = await _dio.get(
      'https://api.thetvdb.com/v4/genres',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    print(response.data['data']);
    return (response.data['data'] as List)
        .map((genre) => Genre.fromJson(genre))
        .toList();
  }
}
