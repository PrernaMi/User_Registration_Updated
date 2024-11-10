import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  DbHelper getInstance = DbHelper._();
  static final String UserTable = 'user';
  static final String TableCol_Name = 'name';
  static final String TableCol_ID = 'id';
  static final String TableCol_Email = 'email';
  static final String TableCol_Phone = 'phone';
  static final String TableCol_Gender = 'gender';

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
      $TableCol_ID Integer autoincrement primary key,
      $TableCol_Name text,
      $TableCol_Email text,
      $TableCol_Phone text,
      $TableCol_Gender text
      )
      ''');
    });
  }

}
