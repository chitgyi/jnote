import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/update_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  final tasks = generateFakeTasks(10);
  final repo = MockTaskRepository();

  test('update task should be success', () async {
    final task = tasks.first.copyWith(title: "update task");

    when(repo.update(task)).thenAnswer((_) async => tasks.first);
    await UpdateTaskUseCase(repo)(task);
    verify(repo.update(task)).called(1);
  });

  test('update task should be failed', () async {
    final task = tasks.first.copyWith(title: "update task");

    when(repo.update(task)).thenThrow(Exception('No Found'));
    expect(
      () => UpdateTaskUseCase(repo)(task),
      throwsA(
        isA<Exception>(),
      ),
    );
    verify(repo.update(task)).called(1);
  });
}
