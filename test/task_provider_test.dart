import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/data/repositories/task_repository_impl.dart';
import 'package:todo_tasks/domain/use_cases/add_task.dart';
import 'package:todo_tasks/domain/use_cases/delete_task.dart';
import 'package:todo_tasks/domain/use_cases/get_tasks.dart';
import 'package:todo_tasks/presentation/providers/task_provider.dart';

void main() {
  test('Add and retrieve tasks', () async {
    final repository = TaskRepositoryImpl();
    final addTask = AddTask(repository);
    final getTasks = GetTasks(repository);
    final deleteTask = DeleteTask(repository);

    final taskListNotifier = TaskListNotifier(getTasks, addTask, deleteTask);

    final container = ProviderContainer(
      overrides: [
        taskListProvider.overrideWith((ref) => taskListNotifier),
      ],
    );

    final taskNotifier = container.read(taskListProvider.notifier);
    final newTask = TaskModel(id: '1', title: 'Test Task');

    taskNotifier.fetchTasks();
    await Future.delayed(Duration.zero);
    expect(container.read(taskListProvider).length, 0);

    taskNotifier.createTask(newTask);
    await Future.delayed(Duration.zero);
    expect(container.read(taskListProvider).length, 1);
    expect(container.read(taskListProvider).first.title, 'Test Task');

    taskNotifier.removeTask('1');
    await Future.delayed(Duration.zero);
    expect(container.read(taskListProvider).isEmpty, true);
  });
}
