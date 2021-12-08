import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:chatapp/models/chat.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) 
    return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await OpenDatabase(
      join(await getDatabasesPath(), 'packdit.db'),
      OnDatabaseCreateFn: (db, version) async {
        await db.execute('''
        CREATE TABLE chats (
          username TEXT PRIMARY KEY, chat TEXT
        )
        ''');
      },
      version: 1
    );
  }

  newChat(newChat) async {
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO chats (
        username, chat
      ) VALUES (?, ?)
    ''', [newChat.username, newChat.chat]);
  }

  Future<dynamic> getChat() async {
    final db = database;
    var res = await db.query("chat");
    if(res.length == 0){
      return null;
    }else{
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}