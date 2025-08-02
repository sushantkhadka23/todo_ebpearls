import 'package:get_it/get_it.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';

import 'package:todo_ebpearls/domain/usecases/add_task.dart';
import 'package:todo_ebpearls/domain/usecases/get_tasks.dart';
import 'package:todo_ebpearls/domain/usecases/update_task.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/domain/usecases/delete_task.dart';
import 'package:todo_ebpearls/domain/usecases/get_task_by_id.dart';
import 'package:todo_ebpearls/domain/usecases/toggle_task_completion.dart';
import 'package:todo_ebpearls/presentation/bloc/theme/theme_bloc.dart';

void registerTaskBlocDependencies(GetIt sl) {
  // Register use cases
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => GetTaskById(sl()));
  sl.registerLazySingleton(() => ToggleTaskCompletion(sl()));

  // Register Bloc with injected use cases from sl
  sl.registerFactory<TaskBloc>(
    () => TaskBloc(
      addTask: sl<AddTask>(),
      deleteTask: sl<DeleteTask>(),
      getTaskById: sl<GetTaskById>(),
      getTasks: sl<GetTasks>(),
      toggleTaskCompletion: sl<ToggleTaskCompletion>(),
      updateTask: sl<UpdateTask>(),
    ),
  );
}

void registerThemeBlocDependencies(GetIt sl) {
  // register theme bloc wtih theme - repo
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(repository: sl<ThemeRepository>()));
}

void registerBlocDependencies(GetIt sl) {
  registerThemeBlocDependencies(sl);
  registerTaskBlocDependencies(sl);
}
