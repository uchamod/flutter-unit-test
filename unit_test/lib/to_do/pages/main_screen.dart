// lib/screens/todo_screen.dart

import 'package:flutter/material.dart';
import 'package:unit_test/to_do/models/models.dart';
import 'package:unit_test/to_do/services/services.dart';

import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = _todoService.getTodos();
  }

  void _refreshTodos() {
    setState(() {
      _todos = _todoService.getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Todos Available'));
          } else {
            return TodoList(
              todos: snapshot.data!,
              onRefresh: _refreshTodos,
              onDelete: (id) async {
                await _todoService.deleteTodo(id);
                _refreshTodos();
              },
              onEdit: (String) {
                // Edit Todo logic here (e.g., show dialog)
                // For simplicity, we will just update the title.
                var updatedTodo = Todo(
                  id: String,
                  title: 'Updated Todo',
                );
                _todoService.updateTodo(updatedTodo);
                _refreshTodos();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add new Todo logic here (e.g., show dialog)
          // For simplicity, we will just add a static Todo.
          var newTodo = Todo(id: DateTime.now().toString(), title: 'New Todo');
          await _todoService.addTodo(newTodo);
          _refreshTodos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
