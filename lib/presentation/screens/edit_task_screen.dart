import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_utils.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_header.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_status_card.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_title_field.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_description_field.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_priority_section.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_due_date_section.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_danger_zone.dart';
import 'package:todo_ebpearls/presentation/widgets/edit_task/edit_task_bottom_section.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskId;

  const EditTaskScreen({super.key, required this.taskId});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Priority? _selectedPriority;
  DateTime? _selectedDueDate;
  bool _isFormValid = true;
  bool _hasChanges = false;
  Task? _task;

  late AnimationController _slideAnimationController;
  late AnimationController _fadeAnimationController;
  late AnimationController _shakeAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _slideAnimationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _fadeAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _shakeAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutQuart));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut));

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _shakeAnimationController, curve: Curves.elasticIn));

    _titleController.addListener(_validateForm);
    _descriptionController.addListener(_checkForChanges);

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _slideAnimationController.dispose();
    _fadeAnimationController.dispose();
    _shakeAnimationController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _titleController.text.trim().isNotEmpty;
    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
    _checkForChanges();
  }

  void _checkForChanges() {
    if (_task == null) return;
    final hasChanges =
        _titleController.text.trim() != _task!.title ||
        _descriptionController.text.trim() != (_task!.description ?? '') ||
        _selectedPriority != _task!.priority ||
        _selectedDueDate != _task!.dueDate;

    if (_hasChanges != hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  void _updateTask() {
    if (_task == null || !_formKey.currentState!.validate() || !_isFormValid || !_hasChanges) return;
    final updatedTask = Task(
      id: _task!.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      isCompleted: _task!.isCompleted,
      createdAt: _task!.createdAt,
      dueDate: _selectedDueDate,
      priority: _selectedPriority!,
    );

    context.read<TaskBloc>().add(ChangeTask(updatedTask));
  }

  void _resetForm() {
    if (_task == null) return;
    setState(() {
      _titleController.text = _task!.title;
      _descriptionController.text = _task!.description ?? '';
      _selectedPriority = _task!.priority;
      _selectedDueDate = _task!.dueDate;
      _hasChanges = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.status is Success && state.task != null) {
          setState(() {
            _task = state.task;
            _titleController.text = _task!.title;
            _descriptionController.text = _task!.description ?? '';
            _selectedPriority = _task!.priority;
            _selectedDueDate = _task!.dueDate;
          });
        } else if (state.status is Success) {
          SnackbarUtils.showSuccess(context, "Update task success");
          Navigator.pop(context);
        } else if (state.status is Failure) {
          _shakeAnimationController.forward().then((_) {
            _shakeAnimationController.reverse();
          });
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
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return PopScope(
          canPop: !_hasChanges,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && _hasChanges) {
              EditTaskUtils.showDiscardChangesDialog(context);
            }
          },
          child: Scaffold(
            appBar: EditTaskAppBar(
              hasChanges: _hasChanges,
              onBack: () {
                if (_hasChanges) {
                  EditTaskUtils.showDiscardChangesDialog(context);
                } else {
                  Navigator.pop(context);
                }
              },
              onReset: _resetForm,
            ),
            body: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: AnimatedBuilder(
                          animation: _shakeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_shakeAnimation.value, 0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const EditTaskHeader(),
                                    const SizedBox(height: 24),
                                    EditTaskStatusCard(
                                      task: _task!,
                                      onToggleCompletion: () {
                                        context.read<TaskBloc>().add(UpdateTaskCompletion(_task!.id, !_task!.isCompleted));
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    EditTaskTitleField(controller: _titleController),
                                    const SizedBox(height: 20),
                                    EditTaskDescriptionField(controller: _descriptionController),
                                    const SizedBox(height: 24),
                                    EditTaskPrioritySection(
                                      selectedPriority: _selectedPriority!,
                                      onPriorityChanged: (priority) {
                                        setState(() {
                                          _selectedPriority = priority;
                                        });
                                        _checkForChanges();
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    EditTaskDueDateSection(
                                      selectedDueDate: _selectedDueDate,
                                      onDueDateSelected: (date) {
                                        setState(() {
                                          _selectedDueDate = date;
                                        });
                                        _checkForChanges();
                                      },
                                    ),
                                    const SizedBox(height: 32),
                                    EditTaskDangerZone(
                                      taskTitle: _task!.title,
                                      onDelete: () => EditTaskUtils.showDeleteConfirmation(context, _task!.id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    EditTaskBottomSection(
                      isFormValid: _isFormValid,
                      hasChanges: _hasChanges,
                      onCancel: () {
                        if (_hasChanges) {
                          EditTaskUtils.showDiscardChangesDialog(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      onSave: _updateTask,
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
