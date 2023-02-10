import 'package:flutter/material.dart';
import 'blocs/task_bloc.dart';
import 'screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (context) => TaskBloc()..add(const LoadTasks(tasks: [ ]))),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const HomeScreen(),
      ),
    );
  }
}
