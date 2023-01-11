import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/get_tasks.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';
import 'package:jnote/src/presentation/notifiers/tasks_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tasks_notifier_test.mocks.dart';

@GenerateMocks([GetTasksUseCase])
void main() {
  final tasks = generateFakeTasks(10);
  final UseCase<List<Task>, NoParams> mockGetTasksUseCase =
      MockGetTasksUseCase();
  test("test on load tasks", () async {
    when(mockGetTasksUseCase.call(const NoParams()))
        .thenAnswer((_) => Future.value(tasks));
    final notifier = TasksNotifier(mockGetTasksUseCase);

    /// check inital data
    expect(notifier.tasks.length, 0);
    await notifier.loadTasks();

    // check data after loaded
    expect(notifier.tasks, tasks);

    verify(mockGetTasksUseCase.call(const NoParams())).called(1);
  });
}
