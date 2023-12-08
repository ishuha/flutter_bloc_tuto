import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tuto/blocs/todos/todos_bloc.dart';
import 'package:flutter_bloc_tuto/models/todo.dart';
import 'package:flutter_bloc_tuto/screens/add_todo_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _TodoCard( BuildContext context, Todo todo) {
    print("${todo.id} ${todo.isCompleted}");
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("#${todo.id}"),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.task),
                Text(todo.description),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () { 
              // todo.isCancelled = !todo.isCancelled;
              // todo.isCompleted = !todo.isCompleted;
              Todo newTodo = todo.copyWith(isCompleted: !todo.isCompleted);

              context.read<TodosBloc>().add(UpdateTodos(todo: newTodo,),);

            }, icon: Icon(todo.isCompleted ? Icons.done_all_rounded : Icons.add_task),),
            IconButton(onPressed: () {
              context.read<TodosBloc>().add(DeleteTodos(todo: todo,),);
              // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text("Material baner"), actions: [ElevatedButton(onPressed: (){}, child: Text("button"))]));
              // Future.delayed(Duration(seconds: 1), (){
              //   ScaffoldMessenger.of(context).hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.swipe);
              // });
            }, icon: const Icon(Icons.cancel),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        buildWhen: (previous, current) {
          if (previous != current) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is TodosLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodosLoaded) {
            if (state is DeleteTodos && context.mounted) {
              // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text("Material baner"), actions: [ElevatedButton(onPressed: (){}, child: Text("button"))]));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Material baner")));
            } else{
              // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text("Material baner else"), actions: [ElevatedButton(onPressed: (){}, child: Text("button"))]));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Material baner Else")));
            }
            List<Todo> todoList = state.todos;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Pending Todos"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return _TodoCard( context, todoList[index]);
                    },
                  ),
                ],
              ),
            );}
          else {
            return Center(
              child: Text("something went wrong"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
