import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ebpearls/core/di/injector/injector.dart';

import 'package:todo_ebpearls/core/router/app_router.dart';
import 'package:todo_ebpearls/core/utils/app_size.dart';
import 'package:todo_ebpearls/core/di/di.dart' as di;
import 'package:todo_ebpearls/domain/usecases/add_task.dart';
import 'package:todo_ebpearls/domain/usecases/delete_task.dart';
import 'package:todo_ebpearls/domain/usecases/get_task_by_id.dart';
import 'package:todo_ebpearls/domain/usecases/get_tasks.dart';
import 'package:todo_ebpearls/domain/usecases/toggle_task_completion.dart';
import 'package:todo_ebpearls/domain/usecases/update_task.dart';
import 'package:todo_ebpearls/presentation/bloc/task_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return BlocProvider(
      create: (context) => TaskBloc(
        addTask: sl<AddTask>(),
        deleteTask: sl<DeleteTask>(),
        getTaskById: sl<GetTaskById>(),
        getTasks: sl<GetTasks>(),
        toggleTaskCompletion: sl<ToggleTaskCompletion>(),
        updateTask: sl<UpdateTask>(),
      )..add(LoadTasks()),
      child: MaterialApp.router(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
