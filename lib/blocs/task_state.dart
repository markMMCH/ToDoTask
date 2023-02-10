part of 'task_bloc.dart';


abstract class TaskState extends Equatable {
  const TaskState();
}


class TasksLoaded extends TaskState {

  final List<Task> tasks;
  const TasksLoaded({this.tasks = const <Task>[]});

  @override
  List<Object> get props => [tasks];
}