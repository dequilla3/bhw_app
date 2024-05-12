import 'dart:convert';

import 'package:bhw_app/config/app_url.dart';
import 'package:http/http.dart' as http;

abstract class ServiceBase<T> {
  Future<T> call();

  Uri url(String url) => Uri.parse(url);

  Uri _getV1Url({String? baseUrl, String? url}) => Uri.parse('$baseUrl/$url');

  Future<Map<String, dynamic>> get(
    String apiUrl,
    String? token,
  ) async {
    String? baseUrl = AppUrl.getBaseUrl();
    return _handleResponse(
        await MyRequest(token).get(_getV1Url(baseUrl: baseUrl, url: apiUrl)));
  }

  Future<Map<String, dynamic>> post(
    String? apirUrl, {
    Map<String, dynamic>? body,
    String? token,
    String? contentType = 'application/json',
  }) async {
    String? baseUrl = AppUrl.getBaseUrl();
    final response = await MyRequest(token).post(
      _getV1Url(baseUrl: baseUrl, url: apirUrl),
      headers: {'Content-Type': contentType!},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  void postOnly({
    Map<String, dynamic>? body,
    String? token,
    String? contentType = 'application/json',
  }) async {
    print(body);
    String? deviceUrl = AppUrl.getDeviceUrl();
    await MyRequest(token).post(
      url('$deviceUrl/data'),
      headers: {'Content-Type': contentType!},
      body: jsonEncode(body),
    );
    print(deviceUrl);
    return;
  }

  Future<Map<String, dynamic>> put(
    String apirUrl, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    String? baseUrl = AppUrl.getBaseUrl();
    final response = await MyRequest(token).put(
      _getV1Url(baseUrl: baseUrl, url: apirUrl),
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
