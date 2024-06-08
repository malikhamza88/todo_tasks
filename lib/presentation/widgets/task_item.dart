import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/presentation/providers/task_provider.dart';

class TaskItem extends ConsumerWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(task.title),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          ref.read(taskListProvider.notifier).removeTask(task.id);
        },
      ),
    );
  }
}
