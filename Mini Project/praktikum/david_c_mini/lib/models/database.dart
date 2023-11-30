import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:david_c_mini/models/category.dart';
import 'package:david_c_mini/models/transaction.dart';
import 'package:david_c_mini/models/transaction_with_category.dart';

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
  int get schemaVersion => 6;

  // CRUD Category

  Future<List<Category>> getAllCategoryRepo(int type) async {
    return await (select(categories)..where((tbl) => tbl.type.equals(type)))
        .get();
  }

  Future updateCategoryRepo(int id, String newName) async {
    return (update(categories)..where((tbl) => tbl.id.equals(id)))
      .write(CategoriesCompanion(name: Value(newName)));
  }

  Future deleteCategoryRepo(int id) async {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  //  CRUD Transaction

  Stream<List<TransactionWithCategory>> getTransactionByDateRepo(DateTime date) {
    final query = (select(transactions).join([innerJoin(categories, categories.id.equalsExp(transactions.category_id))
      ])..where(transactions.transaction_date.equals(date)));

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(row.readTable(transactions), row.readTable(categories));
      }).toList();
    });
  }
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