import 'dart:convert';

import '../../app_config.dart';
import '../../exception/auth_exception.dart';
import '../../models/auth_response.dart';
import '../../models/refresh_token.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart';

import 'auth_service.dart';

class AuthHttpService extends AuthService {
  String apiUrl = "";
  final String _loginPath = '/login';
  final String _refreshPath = '/token';
  final String _registerPath = '/signup';
  final String _logoutPath = '/logout';
  AuthHttpService({this.apiUrl});

  Map<String, String> headers = {
    "Accept": "application/json",
    "Connection": "keep-alive",
    "Content-type": "application/x-www-form-urlencoded",
  };

  Future<AuthResponse> doLogin(User user) async {
    String url = apiUrl ?? AppConfig().get('apiUrl');
    url += _loginPath;
    Map<String, String> bodyReq = user.toJson();

    Response res = await post(url, headers: headers, body: bodyReq);
    //Response res = await post(url, body: body);

    if (res.statusCode == 200) {
      Map<String, dynamic> bodyRes = jsonDecode(res.body);
      AuthResponse auth = AuthResponse.fromJson(bodyRes);
      return auth;
    } else {
      throw AuthException(message: "Login fails!");
    }
  }

  Future<AuthResponse> doSignup(User user) async {
    String url = apiUrl ?? AppConfig().get('apiUrl');
    url += _registerPath;
    Map<String, String> bodyReq = user.toJson();

    Response res = await post(url, headers: headers, body: bodyReq);
    //Response res = await post(url, body: body);

    if (res.statusCode == 200) {
      Map<String, dynamic> bodyRes = jsonDecode(res.body);
      AuthResponse auth = AuthResponse.fromJson(bodyRes);
      return auth;
    } else {
      throw ("Signup fails!");
    }
  }

  Future<void> doLogout(RefreshToken token) async {
    String url = apiUrl ?? AppConfig().get('apiUrl');
    url += _logoutPath;
    Map<String, String> bodyReq = token.toJson();

    final client = Client();
    try {
      final response = await client.send(Request("DELETE", Uri.parse(url))
        ..headers.addAll(<String, String>{
          "Accept": "application/json",
          "Connection": "keep-alive",
          "Content-Type": "application/json"
        })
        ..body = json.encode(bodyReq));

      if (response.statusCode != 204) {
        throw ("Logout fails!");
      }
    } finally {
      client.close();
    }
  }

  Future<AuthResponse> doRefresh(RefreshToken token) async {
    String url = apiUrl ?? AppConfig().get('apiUrl');
    url += _refreshPath;
    Map<String, String> bodyReq = token.toJson();

    Response res = await post(url, headers: headers, body: bodyReq);

    if (res.statusCode == 200) {
      Map<String, dynamic> bodyRes = jsonDecode(res.body);
      AuthResponse auth = AuthResponse.fromJson(bodyRes);
      return auth;
    } else {
      throw ("Signup fails!");
    }
  }
}
