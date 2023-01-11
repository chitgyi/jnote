import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/get_tasks.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  final tasks = generateFakeTasks(10);
  final repo = MockTaskRepository();

  test('get tasks should be success', () async {
    when(repo.getAll()).thenAnswer((_) async => tasks);
    final newTasks = await GetTasksUseCase(repo)(const NoParams());
    expect(newTasks, tasks);
    verify(repo.getAll()).called(1);
  });

  test('get tasks should be empty', () async {
    when(repo.getAll()).thenAnswer((_) async => []);
    final newTasks = await GetTasksUseCase(repo)(const NoParams());
    expect(newTasks.length, 0);
    verify(repo.getAll()).called(1);
  });
}
