import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/save_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  final tasks = generateFakeTasks(10);
  final repo = MockTaskRepository();

  test('save task should be success', () async {
    final task = tasks.first;
    when(repo.save(task.title, task.description))
        .thenAnswer((_) async => tasks.first);
    await SaveTaskUseCase(repo)(SaveTaskParams(task.title, task.description));
    verify(repo.save(task.title, task.description)).called(1);
  });

  test('save task should be failed', () async {
    final task = tasks.first;

    when(repo.save(task.title, task.description))
        .thenThrow(Exception('No Found'));
    expect(
      () => SaveTaskUseCase(repo)(SaveTaskParams(task.title, task.description)),
      throwsA(
        isA<Exception>(),
      ),
    );
    verify(repo.save(task.title, task.description)).called(1);
  });
}
