import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();
  static final String UserTable = 'user';
  static final String TableCol_Name = 'name';
  static final String TableCol_ID = 'id';
  static final String TableCol_Email = 'email';
  static final String TableCol_Phone = 'phone';
  static final String TableCol_Gender = 'gender';
  static final String TableCol_IsSubmitted = 'isSubmit';

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory myDir = await getApplicationDocumentsDirectory();
    String rootPath = join(myDir.path, 'user.db');
    return openDatabase(rootPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''
      create table $UserTable ( 
      $TableCol_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $TableCol_Name text,
      $TableCol_Email text,
      $TableCol_Phone text,
      $TableCol_Gender text,
      $TableCol_IsSubmitted integer
      )
      ''');
    });
  }

  //get offline save data using filtering of is submitted = false

  Future<List<UserModel>> getOfflineData() async {
    var db = await getDb();
    List<UserModel> offlineData = [];
    List<Map<String, dynamic>> mData = await db
        .query(UserTable, where: '$TableCol_IsSubmitted = ?', whereArgs: [0]);
    for (Map<String, dynamic> eachMap in mData) {
      offlineData.add(UserModel.fromMap(map: eachMap));
    }
    return offlineData;
  }

  Future<List<UserModel>> getOnlineData() async {
    var db = await getDb();
    List<UserModel> offlineData = [];
    List<Map<String, dynamic>> mData = await db
        .query(UserTable, where: '$TableCol_IsSubmitted = ?', whereArgs: [1]);
    for (Map<String, dynamic> eachMap in mData) {
      offlineData.add(UserModel.fromMap(map: eachMap));
    }
    return offlineData;
  }

  // update function here
  Future<bool> updateInDb({required UserModel newUser}) async {
    var db = await getDb();
    int count = await db.update(
      UserTable,
      newUser.toMap(),
    );
    int c2 = await db
        .delete(UserTable, where: '$TableCol_IsSubmitted = ?', whereArgs: [1]);
    return count > 0 && c2 > 0;
  }

  //add data in table function here with by default submitted offline

  Future<bool> addInDb({required UserModel newUser}) async {
    var db = await getDb();
    int count = await db.insert(
        UserTable,
        UserModel(
                name: newUser.name,
                email: newUser.email,
                phone: newUser.phone,
                gender: newUser.gender)
            .toMap());
    return count > 0;
  }
}
