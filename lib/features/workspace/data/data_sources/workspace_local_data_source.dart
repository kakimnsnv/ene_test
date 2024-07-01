// features/workspace/data/datasources/workspace_local_data_source.dart

import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class WorkspaceLocalDataSource {
  Future<List<Workspace>> getWorkspaces();
  Future<void> addWorkspace(Workspace workspace);
  Future<void> removeWorkspace(int id);
  Future<List<Workspace>> searchWorkspaces(String searchText);
}

class WorkspaceLocalDataSourceImpl implements WorkspaceLocalDataSource {
  static const String _tableName = 'workspaces';
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'workspace_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
    );
  }

  @override
  Future<List<Workspace>> getWorkspaces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Workspace(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  @override
  Future<void> addWorkspace(Workspace workspace) async {
    final db = await database;
    await db.insert(
      _tableName,
      workspace.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeWorkspace(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Workspace>> searchWorkspaces(String searchText) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$searchText%'],
    );

    return List.generate(maps.length, (i) {
      return Workspace(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }
}
