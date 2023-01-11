import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@Injectable(as: UseCase<Task, int>)
class GetTaskUseCase implements UseCase<Task, int> {
  final TaskRepository _repository;

  GetTaskUseCase(this._repository);

  @override
  Future<Task> call(int id) => _repository.getById(id);
}
