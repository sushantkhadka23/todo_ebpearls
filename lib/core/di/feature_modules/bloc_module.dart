import 'package:get_it/get_it.dart';

import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/bloc/theme/theme_bloc.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';

void registerTaskBlocDependencies(GetIt sl) {
  // Register Bloc with injected use cases from sl
  sl.registerFactory<TaskBloc>(() => TaskBloc(taskRepository: sl<TaskRepository>()));
}

void registerThemeBlocDependencies(GetIt sl) {
  // register theme bloc wtih theme - repo
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(repository: sl<ThemeRepository>()));
}

void registerBlocDependencies(GetIt sl) {
  registerThemeBlocDependencies(sl);
  registerTaskBlocDependencies(sl);
}
