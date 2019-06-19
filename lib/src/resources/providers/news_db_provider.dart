import 'dart:io';
import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository/cache_repository.dart';
import 'package:news/src/resources/repository/source_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


final newsDbProvider = NewsDbProvider();

class NewsDbProvider implements Source, Cache{

  Database db;

  NewsDbProvider(){
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'items1.db');

    db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database newDb, int version){
          newDb.execute('''
            CREATE TABLE Items
              (
                 id INTEGER PRIMARY KEY,
                 type TEXT,
                 by TEXT,
                 time INTEGER,
                 text STRING,
                 parent INTEGER,
                 kids BLOB,
                 dead INTEGER,
                 deleted INTEGER,
                 url TEXT,
                 score INTEGER,
                 title TEXT,
                 descendants INTEGER
              )
          ''');
        }
    );
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id]
    );

    if(maps.length > 0){
      return ItemModel.fromDb(maps.first);

    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel item){

    return db.insert('Items', item.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Todo - store and fetch top ids
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<int> clear(){
    return db.delete('Items');
  }

}