import 'package:JWTAuthApp/app_config.dart';
import 'package:JWTAuthApp/environment.dart';
import 'package:JWTAuthApp/models/auth_response.dart';
import 'package:JWTAuthApp/models/user_model.dart';
import 'package:JWTAuthApp/services/auth-api/auth_http_service.dart';
import 'package:flutter_test/flutter_test.dart';

const fakeUser = {
  "username": "utente@primo.it",
  "password": "s3cr3t",
};

Future<void> main() async {
  //TestWidgetsFlutterBinding.ensureInitialized();
  User user = User.fromJson(fakeUser);
  test('login test', () async {
    AuthResponse resp =
        await AuthHttpService(apiUrl: 'http://127.0.0.1:3000').doLogin(user);
    expect(resp.success, true);
  });
}
