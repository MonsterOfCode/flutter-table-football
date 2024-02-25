import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late final Dio _dio;
  String? _baseUrl;
  final Map<String, CancelToken> _tokens = {};

  // Private constructor
  DioService._internal();

  factory DioService() {
    if (_instance._baseUrl == null) {
      _instance._baseUrl = baseURL;
      _instance._dio = Dio(BaseOptions(baseUrl: baseURL));
      _instance._dio.options.headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
      };
      debugPrint("Dio services is initialized!");
    }
    return _instance;
  }

  /// GET request method with cancellation support
  ///
  /// [tag] - tag used to identify request to allow cancelation of the request
  /// [path] - relative path to the endpoint
  /// [queryParams] - map of params to add to the request
  Future<Response?> get(String tag, String path, {Map<String, dynamic>? queryParams}) async {
    _tokens[tag] = CancelToken();

    try {
      return await _dio.get(path, queryParameters: queryParams, cancelToken: _tokens[tag]);
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        debugPrint("Request canceled!");
        return null;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  /// Post request method with cancellation support
  ///
  /// [tag] - tag used to identify request to allow cancelation of the request
  /// [path] - relative path to the endpoint
  /// [data] - map of data to be sent
  Future<Response?> post(String tag, String path, {Map<String, dynamic>? data}) async {
    _tokens[tag] = CancelToken();

    try {
      return await _dio.post(path, data: data, cancelToken: _tokens[tag]);
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        debugPrint("Request canceled!");
        return null;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  /// Put request method with cancellation support
  ///
  /// [tag] - tag used to identify request to allow cancelation of the request
  /// [path] - relative path to the endpoint
  /// [data] - map of data to be sent
  Future<Response?> put(String tag, String path, {Map<String, dynamic>? data}) async {
    _tokens[tag] = CancelToken();

    try {
      return await _dio.put(path, data: data, cancelToken: _tokens[tag]);
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        debugPrint("Request canceled!");
        return null;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  /// Cancel all the tokens or just one if receives a tag
  ///
  /// [tag] - tag of the request to cancel
  void cancelRequests({String? tag}) {
    if (tag == null) {
      _tokens.values.forEach((element) => element.cancel('All requests was cancelled'));
      _tokens.clear();
      return;
    }
    if (_tokens.containsKey(tag)) {
      _tokens[tag]!.cancel('Cancelled by user');
      _tokens.remove(tag);
    }
  }
}
