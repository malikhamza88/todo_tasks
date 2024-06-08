import 'package:todo_tasks/data/models/task_model.dart';
import 'package:todo_tasks/data/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  List<TaskModel> call() {
    return repository.getTasks();
  }
}
