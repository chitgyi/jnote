import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:jnote/src/data/local_datasource/task_local_datasource.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/utils/constants/hive_keys.dart';
import 'package:jnote/src/utils/exceptions/db_exception.dart';

@Injectable(as: TaskLocalDatasource)
class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  Future<Box<Task>> get _openBox => Hive.openBox<Task>(HiveKeys.taskBoxName);

  @override
  Future<void> delete(Task task) async {
    (await _openBox).delete(task.id);
  }

  @override
  Future<List<Task>> getAll() async {
    return (await _openBox).values.toList();
  }

  @override
  Future<Task> getById(int id) async {
    final task = (await _openBox).get(id);
    if (task == null) throw DbException('No Task Found');
    return task;
  }

  @override
  Future<Task> save(String title, String description) async {
    final id = (await _openBox).keys.length + 1;
    final task = Task(id, title, description);
    update(task);
    return task;
  }

  @override
  Future<Task> update(Task task) async {
    (await _openBox).put(task.id, task);
    return getById(task.id);
  }
}
