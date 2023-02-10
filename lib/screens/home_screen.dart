import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_task/blocs/task_bloc.dart';
import 'package:to_do_app_task/models/task_model.dart';
import 'package:uuid/uuid.dart';
import '../widgets/task_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TextEditingController _dateController;
  late TextEditingController _taskController;
  final  _formKey = GlobalKey<FormState>();
  RegExp exp = RegExp(r"[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{4}$"); //regex for dd.mm.yyyy format of date

  @override
  void initState() {
    _dateController = TextEditingController();
    _taskController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Your Tasks!'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: _dateController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'date',
                              helperText: 'DD/MM/YYYY',
                              helperMaxLines: 2,
                              errorMaxLines: 4
                            ),
                            onChanged: (val) {
                              setState(() {
                                _formKey.currentState!.validate();
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'add a date with DD/MM/YYYY format';
                              } else if (!exp.hasMatch(value)) {
                                return 'wrong format';
                              }
                              return null;
                            },
                          )),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _taskController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: 'task',
                            ),
                            onChanged: (val) {
                              setState(() {
                                _formKey.currentState!.validate();
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'add a task';
                              }
                              return null;
                            },
                          )),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<TaskBloc>().add(AddTask(task: Task(
                          date: _dateController.text, task: _taskController.text, id: const Uuid().v1())));
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _taskController.clear();
                        _dateController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Task'),
                  style: ElevatedButton.styleFrom(elevation: 10),
                ),
                if (_dateController.text.isNotEmpty || _taskController.text.isNotEmpty)
                  ListTile(
                    title: Text('date: ${_dateController.text}'),
                    subtitle: Text('task: ${_taskController.text}'),
                  ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                      if (state is TasksLoaded) {
                      return Expanded(
                        child: state.tasks.isNotEmpty ? ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (ctx, ind) {
                              return TaskCard(task: state.tasks[ind],);
                            }) : const Center(child: Text('No tasks added yet!'),),
                      );
                    } else {
                      return const Text('An error occurred');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
