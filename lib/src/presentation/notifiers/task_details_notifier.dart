import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';
import 'package:jnote/src/presentation/notifiers/view_state.dart';
import 'package:jnote/src/utils/exceptions/db_exception.dart';

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

  final desController = TextEditingController();
  final titleController = TextEditingController();

  Future<void> loadTask(int id) async {
    try {
      final value = await _getTask(id);
      titleController.text = value.title;
      desController.text = value.description;
      viewState = ViewState.success(value);
    } on DbException catch (e) {
      viewState = ViewState.failed(e.message);
    }
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    if (task.description.isEmpty || task.title.isEmpty) {
      return Future.error('Please enter title and description');
    }
    await _updateTask(task);
  }

  Future<void> deleteTask(Task task) => _deleteTask(task);
}
