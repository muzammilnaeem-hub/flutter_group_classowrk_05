import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_model.dart';

class TodoStorage {
  static const String key = 'todos';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(todos.map((e) => e.toJson()).toList());
    await prefs.setString(key, encoded);
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data != null) {
      final decoded = jsonDecode(data) as List;
      return decoded.map((e) => Todo.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
