import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_bloc.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_event.dart';
import 'package:zarity_health_assignment/data/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 20.h,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "My Tasks",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Gap(15.h),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              Task task = widget.tasks[index];
              return ListTile(
                leading: Checkbox(
                  onChanged: (checked) {
                    setState(() {
                      task.completed = checked;
                    });
                    BlocProvider.of<TaskBloc>(context).add(
                      TaskCheckboxToggled(widget.tasks),
                    );
                  },
                  value: task.completed,
                  activeColor: Theme.of(context).primaryColor,
                ),
                visualDensity: const VisualDensity(
                  horizontal: 0.3,
                  vertical: 0.5,
                ),
                title: Text(
                  task.task!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 17.sp),
                ),
                subtitle: Text(task.description!),
              );
            },
          ),
        ],
      ),
    );
  }
}
