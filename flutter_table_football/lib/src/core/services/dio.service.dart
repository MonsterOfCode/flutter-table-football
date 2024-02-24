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
      debugPrint("Dio services is initialized!");
    }
    return _instance;
  }

  /// GET request method with cancellation support
  ///
  /// [tag] - tag used to identify request to allow cancelation of the request
  /// [path] - relative path to the endpoint
  Future<Response> getRequest(String tag, String path, {Map<String, dynamic>? queryParams}) async {
    _tokens[tag] = CancelToken();
    return await _dio.get(path, queryParameters: queryParams, cancelToken: _tokens[tag]);
  }

  /// Cancel all the tokens or just one if receives a tag
  ///
  /// [tag] - tag of the request to cancel
  void cancelRequests({String? tag}) {
    if (tag != null && _tokens.containsKey(tag)) {
      _tokens[tag]!.cancel('Cancelled by user');
      _tokens.remove(tag);
    } else {
      _tokens.values.forEach((element) => element.cancel('All requests was cancelled'));
      _tokens.clear();
    }
  }
}
