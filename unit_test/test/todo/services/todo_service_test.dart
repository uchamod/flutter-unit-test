import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unit_test/to_do/models/models.dart';
import 'package:unit_test/to_do/services/services.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });
  final todoService = TodoService();
  group("todo service testing", () {
    test("add todo test", () async {
      //add new todo
      Todo newTodo = Todo(id: "1", title: "test-todo", isCompleted: false);
      await todoService.addTodo(newTodo);

      //retrive new todo
      final todos = await todoService.getTodos();
      expect(todos.length, 1);
      expect(todos[0].title, "test-todo");
    });

    test("update existing todo", () async {
      //add new todo
      Todo newTodo = Todo(id: "2", title: "test-todo", isCompleted: false);
      await todoService.addTodo(newTodo);

      var updatedToDo = newTodo.copyWith(title: "updated-title");
      await todoService.updateTodo(updatedToDo);
      final todos = await todoService.getTodos();
      expect(todos[1].title, updatedToDo.title);
    });

    test("detete todo", () async {
      Todo newTodo = Todo(id: "3", title: "test-todo", isCompleted: false);
      await todoService.addTodo(newTodo);
      await todoService.deleteTodo(newTodo.id);
      final todos = await todoService.getTodos();

      expect(todos.length, 2);
    });
  });
}
