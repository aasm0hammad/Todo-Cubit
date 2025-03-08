import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/todo_model.dart';

class DbHelper {
  /// private Constructor
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  static const String TABLE_TODO = "todos";
  static const String COLUMN_TODO_ID = "tID";
  static const String COLUMN_TODO_TITLE = "tTitle";
  static const String COLUMN_TODO_DESC = "tDesc";
  static const String COLUMN_TODO_CREATED_AT = "tCreatedAT";
  static const String COLUMN_TODO_COMPLETED = "tCompleted";

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await opneDB();
    return _db!;
  }

  Future<Database> opneDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDocDir.path, 'todoBD.db');

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      ///create DataBase
      db.execute(
          "create table $TABLE_TODO ( $COLUMN_TODO_ID integer primary key autoincrement , $COLUMN_TODO_TITLE text, $COLUMN_TODO_DESC text, $COLUMN_TODO_CREATED_AT text, $COLUMN_TODO_COMPLETED integer )");
    });
  }

  Future<bool> addTodo(TodoModel newTodo) async {
    Database db = await getDB();

    int rowEffected = await db.insert(TABLE_TODO, newTodo.toMap());

    return rowEffected > 0;
  }

  Future<List<TodoModel>> fetchAllTodo() async {
    Database db = await getDB();
    List<Map<String, dynamic>> mTodo = await db.query(TABLE_TODO);

    List<TodoModel> allTodo = [];

    for (Map<String, dynamic> eachTodo in mTodo) {
      allTodo.add(TodoModel.forMap(eachTodo));
    }
    return allTodo;
  }

  Future<bool> updateTodo(TodoModel update,)async{
    Database db =await getDB();

    int rowEffected =await db.update(TABLE_TODO, update.toMap(),where: '$COLUMN_TODO_ID=?' ,whereArgs: ["${update.tID}"]);

    return rowEffected>0;

  }

  Future<bool> deleteTodo(int id) async {
    Database db = await getDB();

    int rowEffected = await db.delete(TABLE_TODO, where: '$COLUMN_TODO_ID=$id');

    return rowEffected > 0;
  }

  Future<bool> completed({required int todoId,required int isComplete})async{

    Database db =await getDB();

    int rowEffected = await db.update(TABLE_TODO,{ COLUMN_TODO_COMPLETED:isComplete,}, where: "$COLUMN_TODO_ID=?", whereArgs: ["$todoId"]);

    return rowEffected>0;

  }
}
