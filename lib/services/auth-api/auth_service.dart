import '../../models/model.dart';

abstract class AuthService {
  Future<AuthResponse> doLogin(User user);
  Future<AuthResponse> doRefresh(RefreshToken token);
  Future<AuthResponse> doSignup(User user);
  Future<void> doLogout(RefreshToken token);
}
