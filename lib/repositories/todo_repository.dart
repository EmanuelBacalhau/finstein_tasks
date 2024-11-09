import 'dart:convert';

import 'package:finstein_tasks/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoRepository {
  late SharedPreferences sharedPreferences;
  String key = 'todos';

  void save(List<Todo> todos) {
    List<String> todosString = todos.map((todo) => json.encode(todo)).toList();

    sharedPreferences.setStringList(key, todosString);
  }

  void deleteAll() async {
    sharedPreferences.remove(key);
  }

  void delete(int indexTodoDeleted) async {
    List<Todo> todos = await getAll();
    todos.removeAt(indexTodoDeleted);
    save(todos);
  }

  Future<List<Todo>> getAll() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String> todosString = sharedPreferences.getStringList(key) ?? [];
    List<Todo> todos =
        todosString.map((todo) => Todo.fromJson(json.decode(todo))).toList();

    return todos;
  }
}
