import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/screens/add_task_screen.dart';
import 'package:todo_ebpearls/presentation/screens/edit_task_screen.dart';
import 'package:todo_ebpearls/presentation/screens/settings_screen.dart';
import 'package:todo_ebpearls/presentation/screens/task_list_screen.dart';
import 'package:todo_ebpearls/presentation/screens/view_task_screen.dart';
import 'package:todo_ebpearls/presentation/screens/welcome_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.welcome,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: AppRoutes.welcome, name: AppRoutesName.welcome, builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: AppRoutes.taskList, name: AppRoutesName.taskList, builder: (context, state) => const TaskListScreen()),
      GoRoute(path: AppRoutes.addTask, name: AppRoutesName.addTask, builder: (context, state) => const AddTaskScreen()),
      GoRoute(
        path: '${AppRoutes.editTask}/:taskId',
        name: AppRoutesName.editTask,
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          context.read<TaskBloc>().add(GetSingleTask(taskId));
          return EditTaskScreen(taskId: taskId);
        },
      ),
      GoRoute(
        path: '${AppRoutes.viewTask}/:taskId',
        name: AppRoutesName.viewTask,
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          context.read<TaskBloc>().add(GetSingleTask(taskId));
          return ViewTaskScreen(taskId: taskId);
        },
      ),
      GoRoute(path: AppRoutes.settings, name: AppRoutesName.settings, builder: (context, state) => const SettingsScreen()),
    ],
  );
}
