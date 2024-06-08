import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/data/repositories/task_repository_impl.dart';
import 'package:todo_tasks/domain/use_cases/add_task.dart';
import 'package:todo_tasks/domain/use_cases/delete_task.dart';
import 'package:todo_tasks/domain/use_cases/get_tasks.dart';

final taskRepositoryProvider = Provider<TaskRepositoryImpl>((ref) {
  return TaskRepositoryImpl();
});

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<TaskModel>>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return TaskListNotifier(GetTasks(repository), AddTask(repository), DeleteTask(repository));
});

class TaskListNotifier extends StateNotifier<List<TaskModel>> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;

  TaskListNotifier(this.getTasks, this.addTask, this.deleteTask) : super([]) {
    fetchTasks();
  }

  void fetchTasks() {
    state = getTasks();
  }

  void createTask(TaskModel task) {
    state = [...state, task];
    addTask(task);
  }

  void removeTask(String id) {
    deleteTask(id);
    state = state.where((task) => task.id != id).toList();
  }
}
