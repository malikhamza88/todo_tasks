import 'package:todo_tasks/data/models/task_model.dart';

abstract class TaskRepository {
  List<TaskModel> getTasks();
  void addTask(TaskModel task);
  void deleteTask(String id);
}
