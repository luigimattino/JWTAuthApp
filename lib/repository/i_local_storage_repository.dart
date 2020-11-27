abstract class ILocalStorageRepository {
  Future getItem(String key);
  Future<void> save(String key, dynamic item);
  Future<void> delete(String key);
}
