import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api4.thetvdb.com",
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  DioService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _secureStorage.read(key: 'bearerToken');
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = 'Bearer $token'; // Correctly format the token
          }
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Do something with the response data if needed
          return handler.next(response); // continue
        },
        onError: (DioException error, handler) {
          // Handle errors
          if (error.response != null) {
            switch (error.response!.statusCode) {
              case 400:
                print('Bad request: ${error.response!.data}');
                break;
              case 401:
                print('Unauthorized: ${error.response!.data}');
                break;
              case 500:
                print('Server error: ${error.response!.data}');
                break;
              default:
                print('Error: ${error.response!.statusCode} - ${error.response!.data}');
            }
          } else {
            print('Unexpected error: ${error.message}');
          }
          return handler.next(error); // continue
        },
      ),
    );
  }

  Dio get dio => _dio;
}
