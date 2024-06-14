import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String> fetchBearerToken(String apiKey , String? pin) async {
    final data = {'apikey' : apiKey};
    if(pin != null)
    {
      data['pin'] = pin;
    }
    final response = await _dio.post(
      'https://api4.thetvdb.com/v4/login',
      data: data,
    );

    //print(response);

     final token = response.data['data']['token'];
     await _secureStorage.write(key: 'bearerToken', value: token);

     return token;
  }
}