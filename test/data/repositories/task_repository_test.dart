import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/data/local_datasource/task_local_datasource.dart';
import 'package:jnote/src/data/repositories/task_repository_impl.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskLocalDatasource])
void main() {
  final tasks = generateFakeTasks(5)..sort((a, b) => a.id.compareTo(b.id));
  final mockLocalDatasource = MockTaskLocalDatasource();
  final repository = TaskRepositoryImpl(mockLocalDatasource);

  group('test task repository', () {
    test(
        'task should be able to save and make sure localdatasource `save` is called',
        () async {
      final task = tasks.first;
      when(mockLocalDatasource.save(task.title, task.description))
          .thenAnswer((_) async => task);
      await repository.save(task.title, task.description);
      verify(mockLocalDatasource.save(task.title, task.description)).called(1);
    });

    test('task should be able to get all tasks', () async {
      when(mockLocalDatasource.getAll()).thenAnswer((_) async => tasks);
      await repository.getAll();
      verify(mockLocalDatasource.getAll()).called(1);
    });

    test(
        'task should be able to find by id and make sure localdatasource `getById` is called',
        () async {
      when(mockLocalDatasource.getById(tasks.first.id))
          .thenAnswer((_) => Future.value(tasks.first));
      final task = await repository.getById(tasks.first.id);
      expect(task, tasks.first);
      verify(mockLocalDatasource.getById(tasks.first.id)).called(1);
    });

    test(
        'task should be unable to find by id if does not exist and make sure localdatasource `getById` is called',
        () async {
      when(mockLocalDatasource.getById(1000)).thenThrow(Exception('No Found'));
      expect(() => repository.getById(1000), throwsA(isA<Exception>()));
      verify(mockLocalDatasource.getById(1000)).called(1);
    });

    test('task should be able to delete', () async {
      when(mockLocalDatasource.delete(tasks.first))
          .thenAnswer((_) => Future.value());
      await repository.delete(tasks.first);
      verify(mockLocalDatasource.delete(tasks.first)).called(1);
    });

    test('task should be able to update', () async {
      when(mockLocalDatasource.update(tasks.first))
          .thenAnswer((_) async => tasks.first);
      await repository.update(tasks.first);
      verify(mockLocalDatasource.update(tasks.first)).called(1);
    });
  });
}
