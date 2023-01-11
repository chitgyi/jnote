import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/save_task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';
import 'package:jnote/src/presentation/notifiers/add_task_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_task_provider_test.mocks.dart';

@GenerateMocks([SaveTaskUseCase])
void main() {
  final tasks = generateFakeTasks(10);
  final UseCase<void, SaveTaskParams> mockSaveTaskUseCase =
      MockSaveTaskUseCase();
  final param = SaveTaskParams(tasks.first.title, tasks.first.description);
  test("test on load tasks", () async {
    when(mockSaveTaskUseCase.call(param)).thenAnswer((_) => Future.value());
    final notifier = AddTaskProvider(mockSaveTaskUseCase);

    await notifier.saveTask(tasks.first.title, tasks.first.description);

    verify(mockSaveTaskUseCase.call(param)).called(1);
  });
}
