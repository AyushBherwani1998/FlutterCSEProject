import 'dart:async';
import 'dart:io' as io;
import './user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserDataBase{
  static Database _db;

  Future<Database> get db async {
    //return database if already created
    if (_db != null) return _db;
    //else create the database
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    //to get the application document directory
    io.Directory applicationDocumentsDirectory =
    await getApplicationDocumentsDirectory();
    //joins the path as applicationDocumentsDirectory.path/notes.db
    String path = join(applicationDocumentsDirectory.path, "users.db");
    //create the database and return it to get db
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  //Things to be done when the database is open
  void _onCreate(Database db, int version) async {
    //create the table name Notes
    await db.execute("Create Table User(uid TEXT,email TEXT,password TEXT)");
    print("User Table Created");
  }

  void saveUser(User user) async {
    var databaseClient = await db;
    var res = await databaseClient.rawInsert("INSERT INTO User (uid,email,password)"
        "VALUES(?,?,?)",[user.uid,user.email,user.password]);
    print(res);
  }

  Future<String> getUser(String email,String password) async {
    var databaseClient = await db;
    List<Map> list = await databaseClient.rawQuery('Select uid from User where email = ? and password = ?',[email,password]);
    print(list[0].toString());
    return list[0].toString();

  }

}