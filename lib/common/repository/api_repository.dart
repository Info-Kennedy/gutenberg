import 'dart:convert';

import 'package:gutenberg/common/common.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiRepository {
  final log = Logger();
  final Dio _dio;
  final PreferencesRepository prefRepo;

  ApiRepository(this._dio, this.prefRepo);

  Future<void> _setAuthHeader() async {
    String? authToken = await prefRepo.getPreference(Constants.PREF_KEY_AUTH_TOKEN);
    if (authToken?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
    }
  }

  Future<Map<String, dynamic>> postRequest({required String url, required Map<String, dynamic> data}) async {
    try {
      log.d("ApiRepository:::In postRequest - Request Parameters: $url::: $data");
      await _setAuthHeader();

      String requestUrl = Constants.API_BASE_URL + url;
      final response = await _dio.post(requestUrl, data: data);
      log.d("ApiRepository:::In postRequest - Response from Post: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in postRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> formDataPostRequest({required String url, required FormData data}) async {
    try {
      log.d("ApiRepository:::In formDataRequest - Request Parameters: $url::: ${data.fields.map((x) => x).toString()}");
      await _setAuthHeader();

      String requestUrl = Constants.API_BASE_URL + url;
      final response = await _dio.post(requestUrl, data: data);
      log.d("ApiRepository:::In formDataRequest - Response from Post: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in formDataRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> getRequest({required String url}) async {
    try {
      log.d("ApiRepository:::In getRequest - Request Parameters: $url");
      await _setAuthHeader();

      String requestUrl = Constants.API_BASE_URL + url;
      final response = await _dio.get(requestUrl);
      log.d("ApiRepository:::In getRequest - Response from Get: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in getRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> getOpenUrlRequest({required String requestUrl}) async {
    try {
      _dio.options.headers.remove('Authorization');
      final response = await _dio.get(requestUrl);
      log.d("ApiRepository:::In getRequest - Response from Get: $requestUrl::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in getRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> getRequestWithoutMenu({required String url}) async {
    try {
      log.d("ApiRepository:::In getRequest - Request Parameters: $url");
      await _setAuthHeader();

      String requestUrl = Constants.API_BASE_URL + url;
      final response = await _dio.get(requestUrl);
      log.d("ApiRepository:::In getRequest - Response from Get: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in getRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> putRequest({required String url, required Map<String, dynamic> data}) async {
    try {
      log.d("ApiRepository:::In putRequest - Request Parameters: $url :: data :: $data");
      await _setAuthHeader();

      String requestUrl = Constants.API_BASE_URL + url;
      final response = await _dio.put(requestUrl, data: data);
      log.d("ApiRepository:::In putRequest - Response from Put: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in putRequest: $error");
      throw _handleError(exception);
    }
  }

  Future<Map<String, dynamic>> deleteRequest({required String url}) async {
    try {
      log.d("ApiRepository:::In deleteRequest - Request Parameters: $url::");
      await _setAuthHeader();

      String requestUrl = "${Constants.API_BASE_URL}$url";
      final response = await _dio.delete(requestUrl);
      log.d("ApiRepository:::In deleteRequest - Response from Delete: $url::: $response");
      return _handleResponse(response) as Map<String, dynamic>;
    } on DioException catch (exception, error) {
      log.e("ApiRepository:::Error in deleteRequest: $error");
      throw _handleError(exception);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final responseData = response.data;
      if (responseData is Map) {
        return responseData;
      } else if (responseData is String) {
        try {
          return jsonDecode(responseData);
        } catch (error) {
          throw Exception("Failed to decode response: $error");
        }
      } else {
        return responseData;
      }
    } else {
      throw Exception("Failed to get response: ${response.statusCode} - ${response.statusMessage}");
    }
  }

  Exception _handleError(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.connectionError:
        errorMessage = "Connection Error.";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout.";
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request cancelled.";
        break;
      case DioExceptionType.badResponse:
        errorMessage = "Response error: ${error.response?.statusCode} - ${error.response?.statusMessage}";
        break;
      case DioExceptionType.unknown:
      default:
        errorMessage = "Connection error: ${error.message}";
    }
    return Exception(errorMessage);
  }
}
