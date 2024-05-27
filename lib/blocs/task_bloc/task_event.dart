import 'package:zarity_health_assignment/data/task.dart';

abstract class TaskEvent {}

class TaskCheckboxToggled extends TaskEvent {
  List<Task> tasks;

  TaskCheckboxToggled(this.tasks);
}
