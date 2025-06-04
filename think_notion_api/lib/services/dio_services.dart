// ignore_for_file: strict_raw_type

import 'package:dio/dio.dart';

///For net work call services
class DioService {
  ///Instance
  DioService({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
  late final Dio _dio;

  /// GET request
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  /// POST request
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  /// PUT request
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  /// PATCH request
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => _dio.patch(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  /// DELETE request
  Future<Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      () => _dio.delete(
        endpoint,
        options: Options(headers: headers),
      ),
    );
  }

  /// Generic request handler
  Future<Response> _sendRequest(
    Future<Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();
      return response;
    } on DioException catch (e) {
      return Response(
        requestOptions: RequestOptions(),
        statusCode: e.response?.statusCode,
        data: e.response?.data,
        statusMessage: e.message,
      );
      // throw Exception(e.response?.data ?? 'Network request failed');
    } catch (e) {
      throw Exception('Unexpected error occured');
    }
  }
}
