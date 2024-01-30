import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await setDB();
    return _db!;
  }

  DatabaseHelper.internal();

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}main.db";
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT, phoneNumber TEXT)");
  }

  // Insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  // Deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
    return res;
  }

  // Check if the user exists
  Future<bool> userExists(String username) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery('SELECT * FROM User WHERE username = ?', [username]);
    return res.isNotEmpty;
  }

  Future<bool> login(String username, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        'SELECT * FROM User WHERE username = ? AND password = ?',
        [username, password]);
    return res.isNotEmpty;
  }
}

class User {
  String username = "";
  String password = "";
  String phoneNumber = "";
  int id = 0;

  User(this.username, this.password);

  User.map(dynamic obj) {
    username = obj['username'];
    password = obj['password'];
    phoneNumber = obj['phoneNumber'];
    id = obj['id'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["username"] = username;
    map["password"] = password;
    map["phoneNumber"] = phoneNumber;
    if (id > 0) {
      map["id"] = id;
    }
    return map;
  }
}
