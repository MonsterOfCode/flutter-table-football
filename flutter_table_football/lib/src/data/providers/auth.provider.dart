import 'package:dio/dio.dart';
import 'package:flutter_table_football/src/core/services/dio.service.dart';

const basePath = "/auth/";

class AuthProvider {
  /// Request to the API to authenticate a Player
  static Future<Response<dynamic>> authenticate(String nickname) async => DioService().getRequest("authenticate", "$basePath/$nickname");

  /// Cancel the authenticate request
  static void cancelAuthenticateRequest() async => DioService().cancelRequests(tag: "cancelAuthenticateRequest");
}
