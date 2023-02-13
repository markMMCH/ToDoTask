import 'package:flutter/material.dart';
import '/widgets/task_widget.dart';
import '../models/task_model.dart';


class TaskSection extends StatelessWidget {
  const TaskSection({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Text(task.date, style: const TextStyle(fontSize: 20),),
          TaskCard(task: task)
        ],
      );
  }
}
