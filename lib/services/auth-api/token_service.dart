import '../../models/model.dart';
import '../../repository/i_local_storage_repository.dart';
import '../local_storage_service.dart';
import 'package:meta/meta.dart';

class AuthTokenService {
  final LocalStorageService _localStorageService;
  final String _tokenKey = "tokens";

  AuthTokenService({
    @required ILocalStorageRepository localStorageRepository,
  }) : _localStorageService =
            LocalStorageService(localStorageRepository: localStorageRepository);

  Future<AuthData> getAuthData() async {
    Map<String, dynamic> data = await _localStorageService.getItem(_tokenKey);
    if (data == null) {
      return null;
    }
    AuthData authData = AuthData.fromJson(data);
    return authData;
  }

  Future<void> save(AuthData authData) async {
    return await _localStorageService.save(_tokenKey, authData);
  }

  Future<void> delete() async {
    return await _localStorageService.delete(_tokenKey);
  }
}
