import 'package:gestion_des_elements/models/element.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CruddataBase {
  static final CruddataBase _instance = CruddataBase._internal();
  factory CruddataBase() => _instance;

  CruddataBase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDb();
    return _database!;
  }

  Future<Database> _openDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "databaseElements.db");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
CREATE TABLE element(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  description TEXT NOT NULL
)
''');
  }

  Future<int> insertElement(Elements element) async {
    final db = await database;
    return await db.insert('element', element.toMap());
  }

  Future<void> updateElement(Elements element) async {
    final db = await database;
    await db.update('element', element.toMap(), where: 'id = ?', whereArgs: [element.id]);
  }

  Future<void> deleteElement(int id) async {
    final db = await database;
    await db.delete('element', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Elements>> getElements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('element');
    return List.generate(maps.length, (i) {
      return Elements(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        description: maps[i]['description']
      );
    });
  }

  Future<Elements?> getElementById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('element', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Elements(
        id: maps[0]['id'],
        nom: maps[0]['nom'],
        description: maps[0]['description']
      );
    } else {
      return null;
    }
  }
}
