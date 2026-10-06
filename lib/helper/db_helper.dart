import 'package:sqflite/sqflite.dart';

import '../utils/global_variables.dart';

class DBHelper {
  late Database db;

  var instance = DBHelper();

  void init() async {
    db = await openDatabase(appname.toLowerCase().trim());
  }

  void closedb() {
    if (db.isOpen) {
      db.close();
    }
  }
}
