import 'dart:async';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of todos.
  late final Box<Todo> todoBox;

  /// A Stream
  late final Stream<Query<Todo>> queryStream;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.

    todoBox = store.box<Todo>();
    todoBox.removeAll();
    if (todoBox.isEmpty()) {
      _putDemoData();
    }
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }

  Future<List<Todo>> test(String status) async {
    final queryNullText = todoBox.query(Todo_.status.contains(status))
      ..order(Todo_.date, flags: Order.descending);
    return queryNullText.build().find();
  }

  void _putDemoData() {
    final todos = [
      Todo(name: 'Todo A', detail: 'do homework A'),
      Todo(name: 'Todo B', detail: 'do homework B'),
      Todo(name: 'Todo C', detail: 'do homework C'),
      Todo(name: 'Todo D', detail: 'do homework D', status: 'Complete'),
      Todo(name: 'Todo E', detail: 'do homework E', status: 'Complete'),
      Todo(name: 'Todo F', detail: 'do homework F', status: 'Complete')
    ];
    todoBox.putMany(todos);
  }
}
