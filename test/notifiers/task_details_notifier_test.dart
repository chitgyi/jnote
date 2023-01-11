import 'package:flutter_test/flutter_test.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/delete_task.dart';
import 'package:jnote/src/domain/usecases/get_task.dart';
import 'package:jnote/src/domain/usecases/update_task.dart';
import 'package:jnote/src/presentation/notifiers/task_details_notifier.dart';
import 'package:jnote/src/presentation/notifiers/view_state.dart';
import 'package:jnote/src/utils/exceptions/db_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_details_notifier_test.mocks.dart';

@GenerateMocks([GetTaskUseCase, UpdateTaskUseCase, DeleteTaskUseCase])
void main() {
  final tasks = generateFakeTasks(10);
  final mockGetTask = MockGetTaskUseCase();
  final mockUpdateTask = MockUpdateTaskUseCase();
  final mockDeleteTask = MockDeleteTaskUseCase();

  test('test task details on success case (with update and delete)', () async {
    when(mockGetTask.call(1)).thenAnswer((_) async => tasks.first);
    when(mockUpdateTask.call(tasks.first)).thenAnswer((_) async => tasks.last);
    when(mockDeleteTask.call(tasks.last))
        .thenAnswer((realInvocation) => Future.value());

    final notifier =
        TaskDetailsNotifier(mockGetTask, mockUpdateTask, mockDeleteTask);

    // check initi loading state
    expect(notifier.viewState, const ViewState<Task>.loading());
    await notifier.loadTask(1);

    /// check after loaded
    expect(notifier.viewState, ViewState.success(tasks.first));
    verify(mockGetTask.call(1)).called(1);

    notifier.updateTask(tasks.first);
    verify(notifier.updateTask(tasks.first)).called(1);

    notifier.deleteTask(tasks.first);
    verify(notifier.deleteTask(tasks.first)).called(1);
  });

  test('test task details on failed case', () async {
    when(mockGetTask.call(1)).thenThrow(DbException('No Found'));

    final notifier =
        TaskDetailsNotifier(mockGetTask, mockUpdateTask, mockDeleteTask);

    // check initi loading state
    expect(notifier.viewState, const ViewState<Task>.loading());
    await notifier.loadTask(1);

    /// check after load failed
    expect(notifier.viewState, const ViewState<Task>.failed('No Found'));

    verify(mockGetTask.call(1)).called(1);
  });
}
