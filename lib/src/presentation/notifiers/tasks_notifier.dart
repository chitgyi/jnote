import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@injectable
class TasksNotifier extends ChangeNotifier {
  TasksNotifier(this._getTasks);
  List<Task> tasks = [];
  final UseCase<List<Task>, NoParams> _getTasks;

  Future<void> loadTasks() async {
    tasks = await _getTasks(const NoParams());
    tasks.sort((a, b) => b.id.compareTo(a.id));
    notifyListeners();
  }
}
