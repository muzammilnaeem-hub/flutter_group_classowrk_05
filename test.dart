import 'package:test.dart';
import 'package:todo.dart';
import 'package:storagetodo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Save and Load Todos using SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = TodoStorage();
    final todos = [Todo(title: 'Unit Test Task', isDone: true)];

    await storage.saveTodos(todos);
    final loaded = await storage.loadTodos();

    expect(loaded.length, 1);
    expect(loaded[0].title, 'Unit Test Task');
    expect(loaded[0].isDone, true);
  });
}
