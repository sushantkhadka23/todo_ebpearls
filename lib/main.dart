import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_ebpearls/core/constants/app_theme.dart';
import 'package:todo_ebpearls/core/di/injector/injector.dart';

import 'package:todo_ebpearls/core/router/app_router.dart';
import 'package:todo_ebpearls/core/di/di.dart' as di;
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/bloc/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  di.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(repository: sl<ThemeRepository>())..add(LoadTheme())),
        BlocProvider(create: (context) => TaskBloc(taskRepository: sl<TaskRepository>())..add(LoadTasks())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            theme: AppTheme.lightTheme(themeState.seedColor),
            darkTheme: AppTheme.darkTheme(themeState.seedColor),
            themeMode: themeState.mode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
