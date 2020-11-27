import 'package:flutter/foundation.dart';
import '../repository/i_local_storage_repository.dart';

class LocalStorageService {
  LocalStorageService(
      {@required ILocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository;

  ILocalStorageRepository _localStorageRepository;

  Future<dynamic> getItem(String key) async {
    return await _localStorageRepository.getItem(key);
  }

  Future<void> save(String key, dynamic item) async {
    await _localStorageRepository.save(key, item);
  }

  Future<void> delete(String key) async {
    await _localStorageRepository.delete(key);
  }
}
