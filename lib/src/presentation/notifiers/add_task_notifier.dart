import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:jnote/src/di/locator.dart';
import 'package:jnote/src/domain/usecases/save_task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

final addTaskProvider = Provider<AddTaskProvider>(
  (_) => di.get<AddTaskProvider>(),
);

@injectable
class AddTaskProvider {
  AddTaskProvider(
    this._saveTask,
  );

  final UseCase<void, SaveTaskParams> _saveTask;

  Future<void> saveTask(String title, String description) =>
      _saveTask(SaveTaskParams(title, description));
}
