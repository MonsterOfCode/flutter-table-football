abstract class StorageService<T> {
  Future<void> write(T player);
  Future<T?> read();
  Future<void> clean();
}
