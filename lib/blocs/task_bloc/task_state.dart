import 'package:zarity_health_assignment/data/task.dart';

class TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;
  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String error;
  TaskErrorState(this.error);
}

