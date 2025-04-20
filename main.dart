import 'package:flutter/material.dart';
import 'todo.dart';
import 'storagetodo.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TodoStorage _storage = TodoStorage();
  final TextEditingController _controller = TextEditingController();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _todos = await _storage.loadTodos();
    setState(() {});
  }

  Future<void> _addTodo() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(title: _controller.text));
        _controller.clear();
      });
      await _storage.saveTodos(_todos);
    }
  }

  Future<void> _toggle(int index) async {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
    await _storage.saveTodos(_todos);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPrefs ToDo',
      home: Scaffold(
        appBar: AppBar(title: Text('ToDo List')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _controller)),
                  IconButton(icon: Icon(Icons.add), onPressed: _addTodo),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(
                    _todos[i].title,
                    style: TextStyle(
                      decoration: _todos[i].isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: _todos[i].isDone,
                    onChanged: (_) => _toggle(i),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
