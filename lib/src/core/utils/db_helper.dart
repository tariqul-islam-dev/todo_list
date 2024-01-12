import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'constants.dart';

class DBHelper {
  DBHelper._();

  static Future<Database> instance() async {
    return await () async {
      final String dbPath = await getDatabasesPath();
      final String path = p.join(dbPath, Keys.dbName);

      const String tableCreateCmd = '''
        CREATE TABLE ${Keys.todoTable}(
            ${Keys.id} TEXT PRIMARY KEY,
            ${Keys.title} TEXT,
            ${Keys. description} TEXT,
            ${Keys.completed} TEXT,
            ${Keys.date} INTEGER,
            ${Keys.time} INTEGER
          )
          ''';

      return await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(tableCreateCmd);
          });
    }();
  }
}