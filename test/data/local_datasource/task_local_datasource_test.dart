import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:jnote/src/data/local_datasource/impl/task_local_datasource.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/utils/helpers/register_hive_adapters.dart';

void main() {
  final tasks = generateFakeTasks(5);

  setUpAll(() async {
    await setUpTestHive();
    registerHiveAdapters();
  });

  tearDownAll(() {
    tearDownTestHive();
  });

  final TaskLocalDatasourceImpl datasource = TaskLocalDatasourceImpl();

  group('test local datasource', () {
    test('save tasks & get tasks should be same', () async {
      for (var task in tasks) {
        await datasource.save(task.title, task.description);
      }
      final saveTasks = await datasource.getAll();
      expect(tasks, saveTasks);
    });

    test('get by id should not be null if exists', () async {
      final saveTask = await datasource.getById(tasks.first.id);
      expect(saveTask.id, tasks.first.id);
    });

    test('get by id should be throw if does not exist', () async {
      expect(() => datasource.getById(1000), throwsA(isA<Exception>()));
    });

    test('task should not be existed when delete it', () async {
      await datasource.delete(tasks.first);
      expect(
          () => datasource.getById(tasks.first.id), throwsA(isA<Exception>()));
    });

    test("task able to update", () async {
      final task = tasks.first.copyWith(title: 'New Title');
      await datasource.update(task);
      final updatedTask = await datasource.getById(tasks.first.id);
      expect(updatedTask, task);
    });
  });
}
