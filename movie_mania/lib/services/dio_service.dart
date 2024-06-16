import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api4.thetvdb.com", // replace with your base URL
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  DioService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _secureStorage.read(key: 'bearerToken');
        options.headers["Authorization"] = token; // Example for authorization header
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        // Do something with the response data if needed
        return handler.next(response); // continue
      },
      onError: (DioException error, handler) {
        // Handle errors
        if (error.response != null) {
          // You can check the status code and handle different responses
          switch (error.response!.statusCode) {
            case 400:
              // Handle 400 error
              break;
            case 401:
              // Handle unauthorized error
              break;
            case 500:
              // Handle server error
              break;
            // Add more cases if needed
          }
        }
        return handler.next(error); // continue
      },
    ));
  }

  Dio get dio => _dio;
}
