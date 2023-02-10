part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  final List<Task> tasks;

  const LoadTasks({this.tasks = const <Task>[]});

  @override
  List<Object?> get props => [tasks];

}

class AddTask extends TaskEvent {

  final Task task;
  const AddTask({required this.task});

  @override
  List<Object?> get props => [task];

}


class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask({required this.task});

  @override
  List<Object?> get props => [task];

}