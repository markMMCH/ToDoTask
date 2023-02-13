import 'package:equatable/equatable.dart';

class Task extends Equatable {

  final String id;
  final String date;
  final String task;

  const Task({required this.date, required this.task, required this.id});

  @override
  List<Object?> get props => [id, date, task];


}