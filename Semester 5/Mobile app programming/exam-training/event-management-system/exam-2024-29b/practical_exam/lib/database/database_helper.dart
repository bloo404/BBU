import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:practical_exam/models/entity.dart';

class DatabaseHelper {
  static const String _name = 'entity_database.db';
  static Logger logger = Logger();

  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _name),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE events(
            id INTEGER PRIMARY KEY,
            name TEXT,
            organizer TEXT,
            category TEXT,
            capacity INTEGER NOT NULL,
            registered INTEGER NOT NULL
            )''',
        );
      },
      version: 1,
    );
  }

  static Future<List<Entity>> getAll() async {
    final db = await getDatabase();
    final result = await db.query('events');

    logger.log(Level.info, "getAll() result: $result");

    return result.map((e) => Entity.fromJson(e)).toList();
  }

  static Future<Entity> addEntity(Entity entity) async {
    final db = await getDatabase();
    final id = await db.insert('events', entity.toJsonWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    logger.log(Level.info, "addEntity() id: $id");

    return entity.copy(id: id);
  }

  static Future<int> deleteEntity(int id) async {
    final db = await getDatabase();
    final result = await db.delete('events', where: 'id = ?', whereArgs: [id]);

    logger.log(Level.info, "deleteEntity() result: $result");

    return result;
  }

  static Future<void> updateEntity(Entity entity) async {
    final db = await getDatabase();
    await db.update(
      'events',
      entity.toJson(),
      where: 'id = ${entity.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
