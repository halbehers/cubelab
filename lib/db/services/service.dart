import 'package:cubelab/db/models/model.dart';
import 'package:cubelab/db/repositories/repository.dart';
import 'package:cubelab/providers/settings_provider.dart';

abstract class Service<T extends Model<T>> {
  Service({this.settingsProvider});

  SettingsProvider? settingsProvider;

  Repository<T>? _repository;

  Repository<T> get repository {
    return _repository ??= newRepository(settingsProvider);
  }

  Repository<T> newRepository(SettingsProvider? settingsProvider);

  T newEntity() {
    return repository.newEntity();
  }

  Future<T> findById(int id) {
    return repository.findById(id);
  }

  Future<List<T>> findAll() {
    return repository.findAll();
  }

  Future<List<T>> findBy({
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    return repository.findBy(
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<bool> exists(int id) {
    return repository.exists(id);
  }

  Future<int> create(T entity) {
    return repository.create(entity);
  }

  Future<int> update(T entity) {
    return repository.update(entity);
  }

  Future<bool> delete(T entity) {
    return repository.delete(entity);
  }

  Future<bool> deleteById(int id) {
    return repository.deleteById(id);
  }

  Future<int> setup(T entity) async {
    if (entity.id != null && await exists(entity.id!)) {
      return update(entity);
    }

    return create(entity);
  }
}
