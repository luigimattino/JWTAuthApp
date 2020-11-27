class RefreshToken {
  final String token;

  RefreshToken({this.token});

  Map<String, String> toJson() => {
        'token': token,
      };

  factory RefreshToken.fromJson(Map<String, String> json) {
    return RefreshToken(token: json['token']);
  }
}
