class Todo {
  final String id, task, description;
  bool isCompleted, isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  // @override
  List<Object?> get props => [
    id,
    task,
    description,
    isCompleted,
    isCancelled,
  ];

  static List<Todo> todos = [
    Todo(id: "1", task: "task 1", description: "description 11",),
    Todo(id: "2", task: "task 2", description: "description 22",),
  ];
}