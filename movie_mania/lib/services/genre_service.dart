import 'package:dio/dio.dart';
import 'package:movie_mania/models/genre.dart';
import 'package:movie_mania/services/dio_service.dart';

class GenreService {
  final Dio dio = Dio();

  final DioService dioService  = DioService();


  Future<List<Genre>> fetchingGenres() async {

    final response = await dioService.dio.get('/v4/genres');

    return (response.data['data'] as List)
        .map((genre) => Genre.fromJson(genre))
        .toList();

  }
}
