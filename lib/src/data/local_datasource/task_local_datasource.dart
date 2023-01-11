import 'package:jnote/src/domain/entities/task.dart';

abstract class TaskLocalDatasource {
  Future<Task> save(String title, String description);
  Future<Task> update(Task task);
  Future<void> delete(Task task);
  Future<List<Task>> getAll();
  Future<Task> getById(int id);
}
