import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@Injectable(as: UseCase<Task, Task>)
class UpdateTaskUseCase implements UseCase<Task, Task> {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  @override
  Future<Task> call(Task params) => _repository.update(params);
}
