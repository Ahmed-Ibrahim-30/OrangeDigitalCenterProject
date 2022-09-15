import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {

  static Future<Database> initDb() async {
    return sql.openDatabase(
      'odc.db', //database name
      version: 1, //version number
      onCreate: (Database database, int version) async {
        await createTablePlants(database);
      },
    );
  }

  static Future<void> createTablePlants(Database database) async {
    await database.execute("""CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT
      )
      """);

    debugPrint("table Created");
  }

  //add
  static Future<int> addPlant(String title, String descrption) async {
    final db = await SQLHelper.initDb(); //open database
    final data = {'title': title, 'description': descrption}; //create data in map
    final id = await db.insert('plants', data);  //insert
    debugPrint("Data Added");
    return id;
  }

//read all plants
  static Future<List<Map<String, dynamic>>> getPlants() async {
    final db = await SQLHelper.initDb();
    return db.query('plants', orderBy: "id");
  }

  //get plant by id
  static Future<List<Map<String, dynamic>>> getplant(int id) async {
    final db = await SQLHelper.initDb();
    return db.query('plants', where: "id = ?", whereArgs: [id]);
  }

  //update
  static Future<int> updatePlant(int id, String title, String? descrption) async {
    final db = await SQLHelper.initDb();
    final data = {
      'title': title,
      'description': descrption,
    };

    final result =
    await db.update('plants', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
  // Delete
  static Future<void> deletePlant(int id) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("plants", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when : $err");
    }
  }
}
