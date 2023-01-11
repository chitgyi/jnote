import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@Injectable(as: UseCase<void, SaveTaskParams>)
class SaveTaskUseCase implements UseCase<void, SaveTaskParams> {
  final TaskRepository _repository;

  SaveTaskUseCase(this._repository);

  @override
  Future<void> call(SaveTaskParams params) =>
      _repository.save(params.title, params.description);
}

class SaveTaskParams {
  final String title;
  final String description;

  SaveTaskParams(this.title, this.description);

  @override
  operator ==(Object other) =>
      other is SaveTaskParams &&
      other.title == title &&
      other.description == description;

  @override
  int get hashCode => Object.hash(title, description);
}
