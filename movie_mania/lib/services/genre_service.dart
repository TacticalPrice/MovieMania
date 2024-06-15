import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/models/genre.dart';

class GenreService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();


  Future<List<Genre>> fetchingGenres() async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    print(2);
    if (token == null) {
        throw Exception('No token found');
    }

    print('Retrieved token');

    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/genres',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data['data'] as List)
        .map((genre) => Genre.fromJson(genre))
        .toList();

  }
}
