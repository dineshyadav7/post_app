import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/post_model.dart';

class SqfliteDatabase {
  static final SqfliteDatabase instance = SqfliteDatabase.internal();
  factory SqfliteDatabase() => instance;
  static Database? db;

  SqfliteDatabase.internal();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initDatabase();
    return db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT
          )
        ''');
      },
    );
  }

  // Insert Post Data
  Future<void> insertPosts(List<PostModel> posts) async {
    Database db = await database;
    for (var post in posts) {
      await db.insert('posts', post.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Fetch Posts from Local Database
  Future<List<PostModel>> getPosts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');
    return List.generate(maps.length, (i) => PostModel.fromJson(maps[i]));
  }

  // Clear Database
  Future<void> clearDatabase() async {
    Database db = await database;
    await db.delete('posts');
  }
}
