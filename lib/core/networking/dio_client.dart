import 'package:blog_app/core/networking/endpoints.dart';
import 'package:dio/dio.dart';

class DioClient {

  late final Dio dio;

  void initialize() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints().baseURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Response> query(
      String endpoint,
      Map<String, dynamic> parameters,
      ) async {
    return await dio.get(
      endpoint,
      queryParameters: parameters,
    );
  }
}

