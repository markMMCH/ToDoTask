import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_task/blocs/task_bloc.dart';
import 'package:to_do_app_task/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: ListTile(
        title: Text(task.date),
        subtitle: Text(task.task),
        trailing: IconButton(
          onPressed: () {
            context.read<TaskBloc>().add(DeleteTask(task: task));
          },
          icon: Icon(Icons.cancel, color: Colors.red.shade700),
        ),

      ),
    );
  }
}
