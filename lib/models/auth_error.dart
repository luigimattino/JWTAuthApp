class AuthError {
  final bool auth;
  final String message;
  AuthError({this.auth, this.message});

  Map<String, dynamic> toJson() => {
        'auth': auth,
        'message': message,
      };

  factory AuthError.fromJson(Map<String, dynamic> json) {
    return AuthError(
      auth: json['auth'],
      message: json['message'] == null ? null : json['message'],
    );
  }
}
