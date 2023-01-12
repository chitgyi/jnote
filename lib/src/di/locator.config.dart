// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jnote/src/data/local_datasource/impl/task_local_datasource_impl.dart'
    as _i4;
import 'package:jnote/src/data/local_datasource/task_local_datasource.dart'
    as _i3;
import 'package:jnote/src/data/repositories/task_repository_impl.dart' as _i6;
import 'package:jnote/src/domain/entities/task.dart' as _i9;
import 'package:jnote/src/domain/repositories/task_repository.dart' as _i5;
import 'package:jnote/src/domain/usecases/delete_task.dart' as _i13;
import 'package:jnote/src/domain/usecases/get_task.dart' as _i11;
import 'package:jnote/src/domain/usecases/get_tasks.dart' as _i12;
import 'package:jnote/src/domain/usecases/save_task.dart' as _i8;
import 'package:jnote/src/domain/usecases/update_task.dart' as _i10;
import 'package:jnote/src/domain/usecases/usecase.dart' as _i7;
import 'package:jnote/src/presentation/notifiers/add_task_notifier.dart'
    as _i14;
import 'package:jnote/src/presentation/notifiers/task_details_notifier.dart'
    as _i15;
import 'package:jnote/src/presentation/notifiers/tasks_notifier.dart' as _i16;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.TaskLocalDatasource>(() => _i4.TaskLocalDatasourceImpl());
    gh.singleton<_i5.TaskRepository>(
        _i6.TaskRepositoryImpl(gh<_i3.TaskLocalDatasource>()));
    gh.factory<_i7.UseCase<void, _i8.SaveTaskParams>>(
        () => _i8.SaveTaskUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i7.UseCase<_i9.Task, _i9.Task>>(
        () => _i10.UpdateTaskUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i7.UseCase<_i9.Task, int>>(
        () => _i11.GetTaskUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i7.UseCase<List<_i9.Task>, _i7.NoParams>>(
        () => _i12.GetTasksUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i7.UseCase<void, _i9.Task>>(
        () => _i13.DeleteTaskUseCase(gh<_i5.TaskRepository>()));
    gh.factory<_i14.AddTaskProvider>(() =>
        _i14.AddTaskProvider(gh<_i7.UseCase<void, _i8.SaveTaskParams>>()));
    gh.factory<_i15.TaskDetailsNotifier>(() => _i15.TaskDetailsNotifier(
          gh<_i7.UseCase<_i9.Task, int>>(),
          gh<_i7.UseCase<_i9.Task, _i9.Task>>(),
          gh<_i7.UseCase<void, _i9.Task>>(),
        ));
    gh.factory<_i16.TasksNotifier>(() =>
        _i16.TasksNotifier(gh<_i7.UseCase<List<_i9.Task>, _i7.NoParams>>()));
    return this;
  }
}
