import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tuto/blocs/todos/todos_bloc.dart';
import 'package:flutter_bloc_tuto/models/todo.dart';
import 'package:flutter_bloc_tuto/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()..add(LoadTodos(todos: Todo.todos )),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
      title: 'Bloc Pattern Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bloc Pattern: To Dos'),
    //   actions: <Type, Action<Intent>>{
    //   ... WidgetsApp.defaultActions,
    //   ActivateAction: CallbackAction<Intent>(
    //     onInvoke: (Intent intent) {
    //       // Do something here...
    //       print("objecttttttttt");
    //       return null;
    //     },
    //   ),
    // },
    debugShowCheckedModeBanner: false,
    ),
    );
  }
}