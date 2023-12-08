import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tuto/models/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  // TodosBloc() : super(TodosInitial()) {
  TodosBloc() : super(TodosLoading()) {
    on<TodosEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadTodos>(_onLoadTodo);
    on<AddTodos>(_onAddTodo);
    on<UpdateTodos>(_onUpdateTodo);
    on<DeleteTodos>(_onDeleteTodo);
  }

  void _onLoadTodo(LoadTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      emit(TodosLoaded(todos: event.todos));
    });
  }

  void _onAddTodo(AddTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      final state = this.state;
      if (state is TodosLoaded) {
        emit( TodosLoaded(todos: List.from(state.todos)..add(event.todo) ) );
      }
    });
  }

  void _onUpdateTodo(UpdateTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      final state = this.state;
      if (state is TodosLoaded) {
        List<Todo> newList = state.todos.map((e) => e.id == event.todo.id ? event.todo : e ,).toList();
        emit( TodosLoaded(todos: newList, ) );
      }
    });
  }

  void _onDeleteTodo(DeleteTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      final state = this.state;
      if (state is TodosLoaded) {
        // List<Todo> newList = List.from(state.todos)..remove(event.todo);
        List<Todo> newList = state.todos.where((element) => element != event.todo).toList();
        emit( TodosLoaded(todos: newList ) );

      }
    });
  }
}
