import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_header.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_details.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_danger_zone.dart';

class ViewTaskScreen extends StatefulWidget {
  final String taskId;

  const ViewTaskScreen({super.key, required this.taskId});

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Task? _task;

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetSingleTask(widget.taskId));
    _fadeAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutQuart));

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.status is Success && state.task != null) {
          setState(() {
            _task = state.task;
          });
        } else if (state.status is Success && state.task == null) {
          SnackbarUtils.showSuccess(context, "Task deleted successfully");
          Navigator.pop(context);
        } else if (state.status is Failure) {
          SnackbarUtils.showError(context, 'Error: ${(state.status as Failure).exception.toString()}');
          if (_task == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          }
        }
      },
      builder: (context, state) {
        if (state.status is InProgress || _task == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
        }

        return Scaffold(
          appBar: ViewTaskAppBar(taskTitle: _task!.title, onBack: () => Navigator.pop(context)),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ViewTaskHeader(),
                    const SizedBox(height: 24),
                    ViewTaskDetails(task: _task!),
                    const SizedBox(height: 32),
                    ViewTaskDangerZone(
                      taskTitle: _task!.title,
                      onDelete: () => context.read<TaskBloc>().add(RemoveTask(_task!.id)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
