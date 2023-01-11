import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/delete_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  final tasks = generateFakeTasks(10);
  final repo = MockTaskRepository();

  test('delete task should be success', () async {
    when(repo.delete(tasks.first)).thenAnswer((_) => Future.value());
    await DeleteTaskUseCase(repo)(tasks.first);
    verify(repo.delete(tasks.first)).called(1);
  });

  test('delete task should be failed', () async {
    when(repo.delete(tasks.first)).thenThrow(Exception('No Found'));
    expect(
        () => DeleteTaskUseCase(repo)(tasks.first), throwsA(isA<Exception>()));
    verify(repo.delete(tasks.first)).called(1);
  });
}
