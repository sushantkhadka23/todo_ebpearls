// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:todo_ebpearls/core/di/injector/injector.dart';

// import 'package:todo_ebpearls/core/router/app_routes.dart';
// import 'package:todo_ebpearls/domain/usecases/add_task.dart';
// import 'package:todo_ebpearls/domain/usecases/delete_task.dart';
// import 'package:todo_ebpearls/domain/usecases/get_task_by_id.dart';
// import 'package:todo_ebpearls/domain/usecases/get_tasks.dart';
// import 'package:todo_ebpearls/domain/usecases/toggle_task_completion.dart';
// import 'package:todo_ebpearls/domain/usecases/update_task.dart';
// import 'package:todo_ebpearls/presentation/bloc/task_bloc.dart';
// import 'package:todo_ebpearls/presentation/screens/add_task_screen.dart';
// import 'package:todo_ebpearls/presentation/screens/edit_task_screen.dart';
// import 'package:todo_ebpearls/presentation/screens/settings_screen.dart';
// import 'package:todo_ebpearls/presentation/screens/task_list_screen.dart';
// import 'package:todo_ebpearls/presentation/screens/welcome_screen.dart';

// class AppRouter {
//   static final router = GoRouter(
//     initialLocation: AppRoutes.taskList,
//     debugLogDiagnostics: true,
//     routes: [
//       GoRoute(path: AppRoutes.welcome, name: AppRoutesName.welcome, builder: (context, state) => WelcomeScreen()),
//       GoRoute(
//         path: AppRoutes.taskList,
//         name: AppRoutesName.taskList,
//         builder: (context, state) => BlocProvider(
//           create: (context) => TaskBloc(
//             addTask: sl<AddTask>(),
//             deleteTask: sl<DeleteTask>(),
//             getTaskById: sl<GetTaskById>(),
//             getTasks: sl<GetTasks>(),
//             toggleTaskCompletion: sl<ToggleTaskCompletion>(),
//             updateTask: sl<UpdateTask>(),
//           ),
//           child: TaskListScreen(),
//         ),
//       ),
//       GoRoute(
//         path: AppRoutes.addTask,
//         name: AppRoutesName.addTask,
//         builder: (context, state) => BlocProvider(
//           create: (context) => TaskBloc(
//             addTask: sl<AddTask>(),
//             deleteTask: sl<DeleteTask>(),
//             getTaskById: sl<GetTaskById>(),
//             getTasks: sl<GetTasks>(),
//             toggleTaskCompletion: sl<ToggleTaskCompletion>(),
//             updateTask: sl<UpdateTask>(),
//           ),
//           child: AddTaskScreen(),
//         ),
//       ),

//       GoRoute(
//         path: '${AppRoutes.editTask}/:taskId',
//         name: AppRoutesName.editTask,
//         builder: (context, state) {
//           final taskId = state.pathParameters['taskId']!;
//           return BlocProvider(
//             create: (context) => TaskBloc(
//               addTask: sl<AddTask>(),
//               deleteTask: sl<DeleteTask>(),
//               getTaskById: sl<GetTaskById>(),
//               getTasks: sl<GetTasks>(),
//               toggleTaskCompletion: sl<ToggleTaskCompletion>(),
//               updateTask: sl<UpdateTask>(),
//             ),
//             child: EditTaskScreen(taskId: taskId),
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.settings,
//         name: AppRoutesName.settings,
//         builder: (context, state) => BlocProvider(
//           create: (context) => TaskBloc(
//             addTask: sl<AddTask>(),
//             deleteTask: sl<DeleteTask>(),
//             getTaskById: sl<GetTaskById>(),
//             getTasks: sl<GetTasks>(),
//             toggleTaskCompletion: sl<ToggleTaskCompletion>(),
//             updateTask: sl<UpdateTask>(),
//           ),
//           child: SettingsScreen(),
//         ),
//       ),
//     ],
//   );
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/presentation/bloc/task_bloc.dart';
import 'package:todo_ebpearls/presentation/screens/add_task_screen.dart';
import 'package:todo_ebpearls/presentation/screens/edit_task_screen.dart';
import 'package:todo_ebpearls/presentation/screens/settings_screen.dart';
import 'package:todo_ebpearls/presentation/screens/task_list_screen.dart';
import 'package:todo_ebpearls/presentation/screens/welcome_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.taskList,
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
      GoRoute(path: AppRoutes.settings, name: AppRoutesName.settings, builder: (context, state) => const SettingsScreen()),
    ],
  );
}
