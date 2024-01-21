import 'dart:convert';

import 'package:bhw_app/config/app_config.dart';
import 'package:http/http.dart' as http;

abstract class ServiceBase<T> {
  Future<T> call();

  Uri url(String url) => Uri.http(AppConfig.baseUrl, url);

  Uri _getV1Url(String url) => Uri.parse('${AppConfig.baseUrl}/$url');

  Future<Map<String, dynamic>> get(String apiUrl, String? token) async {
    return _handleResponse(await MyRequest(token).get(_getV1Url(apiUrl)));
  }

  Future<Map<String, dynamic>> post(
    String apirUrl, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await MyRequest(token).post(
      _getV1Url(apirUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String apirUrl, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await MyRequest(token).put(
      _getV1Url(apirUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    return jsonDecode(response.body);
  }
}

class MyRequest extends http.BaseClient {
  final String? token;

  MyRequest(this.token);
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request.send();
  }
}
