
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';
part 'task_event.dart';
part 'task_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TasksLoaded()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) {
    emit(TasksLoaded(tasks: event.tasks));
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    if (state is TasksLoaded) {
      emit(TasksLoaded(tasks: (List<Task>.from(state.tasks)..add(event.task))..sort((a, b) => DateFormat('d/M/y').parse(a.date).compareTo(DateFormat('d/M/y').parse(b.date)))));
    }
  }
  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    if (state is TasksLoaded) {
     emit(TasksLoaded(tasks: state.tasks.where((taskElement) => taskElement.id != event.task.id).toList()));
    }
  }

}
