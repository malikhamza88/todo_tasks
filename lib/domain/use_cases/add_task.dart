import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/data/repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  void call(TaskModel task) {
    return repository.addTask(task);
  }
}
