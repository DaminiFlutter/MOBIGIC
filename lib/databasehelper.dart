import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Helper {
  static Database? db;
  static initDB()async {
     db = await openDatabase(join(await getDatabasesPath(),
        'login.db'),version: 1, onCreate: (db, version) {
    return db.execute('CREATE TABLE login(id INTEGER, name TEXT, email TEXT )');
    });
  }
  static insert ({id, name, email}){
    db?.insert('login', {"id":id,"name":name,"email":email});
  }

  static fetch (){
    var data = db?.rawQuery("SELECT * FROM login");
    return data;
  }



}