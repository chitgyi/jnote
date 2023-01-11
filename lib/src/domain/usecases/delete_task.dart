import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@Injectable(as: UseCase<void, Task>)
class DeleteTaskUseCase implements UseCase<void, Task> {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  @override
  Future<void> call(Task params) => _repository.delete(params);
}
