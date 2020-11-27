import 'package:flutter/foundation.dart';

class AuthResponse {
  bool success;
  AuthData data;
  String message;

  AuthResponse({this.success, this.data, this.message});

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data,
        'message': message,
      };

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      data: json['data'] == null ? null : AuthData.fromJson(json['data']),
      message: json['message'] == null ? null : json['message'],
    );
  }
}

class AuthData {
  String accessToken;
  final String refreshToken;

  AuthData({
    @required this.accessToken,
    @required this.refreshToken,
  });

  Map<String, String> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
