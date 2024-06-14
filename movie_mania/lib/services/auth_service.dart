import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<String> fetchBearerToken(String apiKey) async {
    final response = await _dio.post(
      'https://api.thetvdb.com/login',
      data : {'apikey' : ''},
    );
    return response.data['token'];
  }
}