import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/usecases/save_task.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@injectable
class AddTaskProvider {
  AddTaskProvider(
    this._saveTask,
  );

  final UseCase<void, SaveTaskParams> _saveTask;

  Future<void> saveTask(String title, String description) {
    return _saveTask(SaveTaskParams(title, description));
  }
}
