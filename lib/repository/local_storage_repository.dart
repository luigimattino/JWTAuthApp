import 'package:localstorage/localstorage.dart';
import 'i_local_storage_repository.dart';

class LocalStorageRepository implements ILocalStorageRepository {
  final LocalStorage _storage;

  LocalStorageRepository(String storageKey)
      : _storage = LocalStorage(storageKey);

  @override
  Future getItem(String key) async {
    await _storage.ready;

    return _storage.getItem(key);
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await _storage.ready;

    return _storage.setItem(key, value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.ready;
    return _storage.deleteItem(key);
  }
}
