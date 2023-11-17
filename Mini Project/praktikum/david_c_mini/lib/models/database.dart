// import 'package:drift/drift.dart';

// part 'database.g.dart';

// class TodoItems extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text().withLength(min: 6, max: 32)();
//   TextColumn get content => text().named('body')();
//   IntColumn get category => integer().nullable()();
// }

// @DriftDatabase(tables: [TodoItems])
// class AppDatabase extends _$AppDatabase {
// }



import 'dart:io';

import 'package:david_c_mini/models/category.dart';
import 'package:david_c_mini/models/transaction.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// ... the TodoItems table definition stays the same

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [Categories, Transactions]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final database = AppDatabase();

//   await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
//         title: 'todo: finish drift setup',
//         content: 'We can now write queries and define our own tables.',
//       ));
//   List<TodoItem> allItems = await database.select(database.todoItems).get();

//   print('items in database: $allItems');
// }