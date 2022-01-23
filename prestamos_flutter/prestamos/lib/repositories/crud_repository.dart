abstract class CrudRepository<T> {
  //El pathSetion es mejor si se maneja en el servicio, ya que esta clase puede usarse para CRUD de origenes diversos
  Future<List<T>> getAll();

  Future<String> createNew(T object);

  Future<String> update(T object);

  Future<String> delete(int id);

  Future<T> getOne(int id);
}
