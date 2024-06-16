import 'package:dio/dio.dart';
import 'package:movie_mania/services/dio_service.dart';

class UserService {
  final Dio dio = Dio();
  final DioService dioService  = DioService();

  Future<Map<String , dynamic>> fetchUser() async {
    final response = await dioService.dio.get('/v4/user');
    //print(response.data);
    final Map<String , dynamic> data = response.data['data'];
    return data;
  }
}