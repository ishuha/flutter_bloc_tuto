part of 'todos_bloc.dart';

sealed class TodosState extends Equatable {
  const TodosState();
  
  @override
  List<Object> get props => [];
}

final class TodosInitial extends TodosState {}

final class TodosLoading extends TodosState {}

final class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded({ this.todos = const <Todo>[] });

  @override
  List<Object> get props => [todos];
}

