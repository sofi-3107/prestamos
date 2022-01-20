abstract class CrudRepository<T> {
  Future<List<T>> getAll(String pathSection);

  Future<bool> createNew(T object, String pathSection);

  Future<bool> update(T object, String pathSection);

  Future<String> delete(int id, String pathSection);

  Future<T> getOne(int id, String pathSection);
}
