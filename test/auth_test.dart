import 'dart:async';

import 'package:JWTAuthApp/models/auth_error.dart';
import 'package:JWTAuthApp/models/auth_response.dart';
import 'package:JWTAuthApp/models/refresh_token.dart';
import 'package:JWTAuthApp/models/resource_response.dart';
import 'package:JWTAuthApp/models/user_model.dart';
import 'package:JWTAuthApp/services/auth-api/auth_http_service.dart';
import 'package:JWTAuthApp/services/resource-api/resource_service.dart';
import 'package:flutter_test/flutter_test.dart';

const fakeUser = {
  "username": "utente@primo.it",
  "password": "s3cr3t",
};

void main() {
  User user = User.fromJson(fakeUser);
  String accessToken;
  String refreshToken;

  test('Authentication process test', () async {
    AuthHttpService authService =
        AuthHttpService(apiUrl: 'http://127.0.0.1:3000');
    ResourceService resourceService =
        ResourceService(apiUrl: 'http://127.0.0.1:3000');
    AuthResponse resp = await authService.doLogin(user);
    if (resp.success) {
      accessToken = resp.data.accessToken;
      refreshToken = resp.data.refreshToken;
      for (var i = 5; i >= 1; i--) {
        var result = await resourceService.doResources(accessToken);
        if (result is ResourcesResponse) {
          print('Call resources : #' + (result).resources.length.toString());

          await Future.delayed(const Duration(seconds: 6), () async {});
        } else if (result is AuthError) {
          print('Auth failed : ' + (result).message);
          RefreshToken token =
              RefreshToken.fromJson({"token": "$refreshToken"});
          AuthResponse resp2 = await authService.doRefresh(token);
          accessToken = resp2.data.accessToken;
        } else {
          print('Something unexpected happened!');
        }
      }
    }
  });
}
