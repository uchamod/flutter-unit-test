import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test/to_do/models/models.dart';

void main() {
  test('Test Todo Model instance', () {
    // Test Todo Model
    final Todo todo = Todo(id: "1", title: "test-todo");
    expect(todo.id, "1");
    expect(todo.title, "test-todo");
    expect(todo.isCompleted, false);

    final updatedTodo = todo.copyWith(title: "new-title");
    expect(updatedTodo.id, "1");
    expect(updatedTodo.title, "new-title");
    expect(updatedTodo.isCompleted, false);
    
  });
}
