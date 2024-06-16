import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<Map<String , dynamic>> fetchUser() async {
    String? token = await _secureStorage.read(key: 'bearerToken');
    final response = await _dio.get(
      'https://api4.thetvdb.com/v4/user',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
    //print(response.data);
    final Map<String , dynamic> data = response.data['data'];
    return data;
  }
}