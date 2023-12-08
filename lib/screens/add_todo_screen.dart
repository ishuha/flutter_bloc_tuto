import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tuto/blocs/todos/todos_bloc.dart';
import 'package:flutter_bloc_tuto/models/todo.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return BlocListener<TodosBloc, TodosState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is TodosLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "New Todo added successfully",
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bloc Pattern: Add a Todo"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              _InputField(label: "Id", controller: controllerId),
              _InputField(label: "Task", controller: controllerTask),
              _InputField(
                  label: "Description", controller: controllerDescription),
              ElevatedButton(
                  onPressed: () {
                    Todo todo = Todo(
                      id: controllerId.value.text,
                      task: controllerTask.value.text,
                      description: controllerDescription.value.text,
                    );
                    context.read<TodosBloc>().add(
                          AddTodos(todo: todo),
                        );
                    Navigator.of(context).pop();
                  },
                  child: Text("Add To Do")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _InputField(
      {required String label, required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("$label:"),
          SizedBox(
            height: 18,
          ),
          // TextField(
          //   controller: controller,
          // ),
          TextFormField(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
