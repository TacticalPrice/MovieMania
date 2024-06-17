import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/services/dio_service.dart';

class AuthService {
  final Dio dio = Dio();
  final DioService dioService  = DioService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String> fetchBearerToken(String apiKey , String? pin) async {
    final data = {'apikey' : apiKey};
    if(pin != null)
    {
      data['pin'] = pin;
    }
    final response = await dioService.dio.post('/v4/login',
      data: data,
    );

    //print(response);

     final token = response.data['data']['token'];
     await _secureStorage.write(key: 'bearerToken', value: token);

     return token;
  }
}