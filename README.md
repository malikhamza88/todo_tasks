
### Decision and Assumptions for Flutter Task Manager App

#### Decisions

1. **Clean Architecture**
    - **Decision**: Adopt Clean Architecture to structure the application.
    - **Reason**: Clean Architecture ensures separation of concerns, making the codebase more maintainable, testable, and scalable. It also allows each layer to evolve independently.
    - **Implementation**:
        - **Presentation Layer**: Handles the UI and user interactions.
        - **Domain Layer**: Contains the business logic, entities, and use cases.
        - **Data Layer**: Manages data sources and repositories.

2. **State Management with Riverpod**
    - **Decision**: Use Riverpod for state management.
    - **Reason**: Riverpod offers a scalable and robust solution for managing state, decoupling business logic from UI components. This promotes cleaner code and easier testing.
    - **Implementation**:
        - **Providers**: Defined providers for managing task states (`taskRepositoryProvider` and `taskListProvider`).
        - **StateNotifier**: Used `StateNotifier` to manage the state of the task list, ensuring UI updates on state changes.

3. **Core Features Implementation**
    - **Task Listing**:
        - Displays a list of tasks with titles and delete buttons.
        - Uses `taskListProvider` to fetch and display tasks.
    - **Add Task**:
        - Provides a form to add new tasks with a title field and submission button.
        - Updates the state using `taskListProvider`.
    - **Delete Task**:
        - Allows users to delete tasks from the list.
        - Updates the state using `taskListProvider`.

4. **Testing**
    - **Unit Tests**: Implemented unit tests for Riverpod providers and use cases to ensure functionality.
    - **Widget Tests**: Created widget tests for main UI components to verify display and functionality.

#### Assumptions

1. **Mock or In-Memory Database for Data Layer**
    - **Assumption**: Using a mock or in-memory database for data storage.
    - **Reason**: Simplifies the setup and focuses on demonstrating Clean Architecture and state management without the overhead of setting up a real database.

2. **Simple UI Design**
    - **Assumption**: A basic UI design is sufficient for this task.
    - **Reason**: The primary focus is on demonstrating architecture and state management principles rather than creating a visually appealing design.

3. **Riverpod Version**
    - **Assumption**: Using the latest version of Riverpod (2.0.0 at the time of development).
    - **Reason**: Ensures compatibility with the latest features and improvements in Riverpod.

4. **StateNotifier for Task Management**
    - **Assumption**: Using `StateNotifier` to manage task states.
    - **Reason**: `StateNotifier` provides a simple yet powerful way to manage state changes and ensure the UI updates accordingly.

5. **No Complex Task Attributes**
    - **Assumption**: Tasks have minimal attributes (id, title, due date, and completion status).
    - **Reason**: Simplifies the implementation and focuses on the core functionality of adding, listing, and deleting tasks.

#### Code Example

```dart
// presentation/providers/task_provider.dart
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
    state = state.where((task) => task.id != id). toList();
  }
}
```
