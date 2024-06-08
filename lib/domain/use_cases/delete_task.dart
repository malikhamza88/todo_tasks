import 'package:todo_tasks/data/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  void call(String id) {
    return repository.deleteTask(id);
  }
}
