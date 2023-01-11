import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/get_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  final tasks = generateFakeTasks(10);
  final repo = MockTaskRepository();

  test('get task should be success', () async {
    when(repo.getById(10)).thenAnswer((_) async => tasks.first);
    final task = await GetTaskUseCase(repo)(10);
    expect(task, tasks.first);
    verify(repo.getById(10)).called(1);
  });

  test('get task should be failed', () async {
    when(repo.getById(10)).thenThrow(Exception('No Found'));
    try {
      await GetTaskUseCase(repo)(10);
    } catch (e) {
      expect(e.toString(), isA<String>());
    }
    verify(repo.getById(10)).called(1);
  });
}
