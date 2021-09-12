import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:line_graph/env_conf.dart';


Map<String, String> baseHeaders = {'Content-Type': 'application/json'};


class ServiceHttp {

  static String _url(String route) {
    return route.contains('://')
      ? route
      : '${EnvConf.URL_BASE}/$route';
  }


  static Future<Map<String, String>> _getHeaders({String token}) async {
    var headers = {...baseHeaders};

    if (token != null && token.isNotEmpty)
      headers = {...headers, HttpHeaders.authorizationHeader: 'Bearer $token'};

    return headers;
  }


  static Future<http.Response> get(
    String route, [
    bool addAuthToken = false
    ]) async {
    final url = _url(route);

    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(url), headers: headers);

    return response;
  }


  static Future<http.Response> post(
      String route, [
      dynamic body,
      bool addAuthToken = true
    ]) async {
    final url = _url(route);

    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }


  static Future<http.Response> put(
      String route, [
      dynamic body,
      bool addAuthToken = true
    ]) async {
    final url = _url(route);

    final headers = await _getHeaders();
    print("body $body");
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }


  static Future<http.Response> delete(
      String route, [
      dynamic body,
      bool addAuthToken = true
    ]) async {
    final url = _url(route);

    final headers = await _getHeaders();
    final request = http.Request('DELETE', Uri.parse(url));
    request.headers.addAll(headers);

    if (body != null) {
      request.body = json.encode(body);
    }

    final response = await http.Client()
      .send(request)
      .then(http.Response.fromStream);

    return response;
  }


  static dynamic parseResponse(http.Response response) {
    Map<String, dynamic> responseBody = {};

    try {
      responseBody = json.decode(response.body);
    } catch (e) {
      return Future.error(
        Exception('Error in parsing response')
      );
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody['result'];
      case 400:
      case 401:
      case 404:
      default:
        return Future.error(
          Exception('Error in response')
        );
    }
  }


  static bool checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
      case 400:
      case 401:
      case 404:
        return false;
      default: break;
    }
    return false;
  }

}
