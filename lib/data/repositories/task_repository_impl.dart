import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/data/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<TaskModel> _tasks = [];

  @override
  List<TaskModel> getTasks() {
    return _tasks;
  }

  @override
  void addTask(TaskModel task) {
    _tasks.add(task);
  }

  @override
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
