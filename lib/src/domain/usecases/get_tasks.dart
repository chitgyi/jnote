import 'package:injectable/injectable.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/domain/repositories/task_repository.dart';
import 'package:jnote/src/domain/usecases/usecase.dart';

@Injectable(as: UseCase<List<Task>, NoParams>)
class GetTasksUseCase implements UseCase<List<Task>, NoParams> {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  @override
  Future<List<Task>> call(NoParams params) => _repository.getAll();
}
