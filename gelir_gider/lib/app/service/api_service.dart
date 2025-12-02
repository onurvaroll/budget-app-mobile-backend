import 'package:dio/dio.dart';
import 'package:gelir_gider/app/constants/api_constants.dart';
import 'package:gelir_gider/app/service/storage_service.dart';
import 'package:get/get.dart' hide Response;

class ApiService {
  late StorageService _storageService;
  late Dio _dio;

  Future<ApiService> init() async {
    _storageService = Get.find<StorageService>();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 90),
        receiveTimeout: Duration(seconds: 90),
        contentType: 'application/json',
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _storageService.getValue<String>(StorageKeys.userToken);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storageService.removeValue(StorageKeys.userToken);
          }
          return handler.next(error);
        },
      ),
    );
    return this;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.get(path, queryParameters: queryParameters, options: options);
    } catch (e) {
      print("Dio GET Error: $e");
      rethrow;
    }
  }

  Future<Response> post(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio POST Error: $e");
      rethrow;
    }
  }

  Future<Response> put(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio PUT Error: $e");
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio delete error $e");
      rethrow;
    }
  }
}
