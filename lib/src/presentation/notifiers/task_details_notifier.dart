import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:jnote/src/di/locator.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';
import 'package:jnote/src/presentation/notifiers/view_state.dart';
import 'package:jnote/src/utils/exceptions/db_exception.dart';

final taskDeatilsProvider =
    ChangeNotifierProvider<TaskDetailsNotifier>((ref) => di.get());

@injectable
class TaskDetailsNotifier extends ChangeNotifier {
  TaskDetailsNotifier(
    this._getTask,
    this._updateTask,
    this._deleteTask,
  );

  ViewState<Task> viewState = const ViewState.loading();

  final UseCase<Task, int> _getTask;
  final UseCase<Task, Task> _updateTask;
  final UseCase<void, Task> _deleteTask;

  Future<void> loadTask(int id) async {
    try {
      final value = await _getTask(id);
      viewState = ViewState.success(value);
    } on DbException catch (e) {
      viewState = ViewState.failed(e.message);
    }

    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _updateTask(task);
  }

  Future<void> deleteTask(Task task) => _deleteTask(task);
}
