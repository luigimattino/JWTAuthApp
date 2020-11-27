class User {
  int id;
  String username;
  String password;

  User({this.id, this.username, this.password});

  Map<String, String> toJson() => {
        'id': id.toString(),
        'username': username,
        'password': password,
      };

  factory User.fromJson(Map<String, String> json) {
    return User(
      id: json['id'] != null ? int.parse(json['id']) : 0,
      username: json['username'],
      password: json['password'],
    );
  }
}
