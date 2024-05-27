import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_event.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_state.dart';
import 'package:zarity_health_assignment/data/task.dart';
import 'package:zarity_health_assignment/services/tasks/tasks_services.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskLoadingState()) {
    _fetchUserTasks();

    on<TaskCheckboxToggled>(
      (event, emit) {
        TasksServices().updateTask(event.tasks);
        emit(TaskLoadedState(event.tasks));
      },
    );
  }

  _fetchUserTasks() async {
    List<Task> tasks = await TasksServices().fetchUserTasks();
    emit(TaskLoadedState(tasks));
  }
}
