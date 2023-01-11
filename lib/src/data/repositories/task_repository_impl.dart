import 'package:injectable/injectable.dart';
import 'package:jnote/src/data/local_datasource/task_local_datasource.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';

@Singleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDatasource;

  TaskRepositoryImpl(this._localDatasource);

  @override
  Future<void> delete(Task task) => _localDatasource.delete(task);

  @override
  Future<List<Task>> getAll() => _localDatasource.getAll();

  @override
  Future<Task> getById(int id) => _localDatasource.getById(id);

  @override
  Future<Task> save(String title, String description) =>
      _localDatasource.save(title, description);

  @override
  Future<Task> update(Task task) => _localDatasource.update(task);
}
