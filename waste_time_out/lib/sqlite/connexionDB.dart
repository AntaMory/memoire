import 'package:sqflite/sqflite.dart';
import 'package:waste_time_out/model/jwt-token.dart';

import 'dart:convert';
import 'dart:io';
import 'package:waste_time_out/model/user.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



  class DatabaseHelper {
    static final _databaseName = "memoire.db";
    static final _databaseVersion = 1;
    static final _tableName = 'user';

    //Inscription User
    static final user="user";
    static final columnId = "UserId";
    static final columnUsername = "username";
    static final columnPassword = "password";
    static final columnFirtName = "firstName";
    static final columnLastName = "lastName";
    static final columnEmail = "email";
    static final columnPhoneNumber = "phoneNumber";
    static final columnAdresse = "adresse";



    DatabaseHelper._privateConstuctor();
    static final DatabaseHelper instance = DatabaseHelper._privateConstuctor();

    static Database? _database;
    Future<Database> get database async =>
        _database ??= await _initDatabase();
    bool responseUser = false;



  //cette fonction permet de l'ouvrir la base de données et la crée si elle n'existe pas
    Future<Database>  _initDatabase() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      return await openDatabase(
          path, version: _databaseVersion, onCreate: _onCreate);
    }

  //creation de la table de la base de donnees
    Future _onCreate(Database db, int version) async {
      await db.execute(''' 
            CREATE TABLE $user ( 
            $columnId INTEGER PRIMARY KEY,
            $columnUsername TEXT NOT NULL,
            $columnPhoneNumber NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnFirtName TEXT NOT NULL,
            $columnLastName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnAdresse TEXT NOT NULL)
            ''');
    }


    //inserer des données dans la table
    Future<int> insert(Map<String, dynamic> row) async {
      Database db = await instance.database;
      return await db.insert(user, row);
    }

    //Lister la base de données
    Future<List<Map<String, dynamic>>> queryAll() async {
      Database db = await instance.database;
      return await db.query(user);
    }

    //Mettre à jour base de données
    Future<int> update(Map<String, dynamic> row) async {
      Database db = await instance.database;
      int id = row[columnId];
      return await db
          .update(user, row, where: '$columnId = ?', whereArgs: [id]);
    }

    //Supprimer dans la base données
    Future<int> delete(int id) async {
      Database db = await instance.database;
      return await db.delete(user, where: '$columnId = ?', whereArgs: [id]);
    }

      //inserer des donnees dans la base


     late JWTToken jwtToken;
     late Map<String, dynamic> tokenJson;

      selectOneRow(username, password) async {
        Database db = await instance.database;

        List<Map> result = await db.rawQuery(
            "SELECT * FROM user WHERE login=? and password=?",
            [username, password]);
        List<Map> users = [];
        for (int i = 0; i < result.length; i++) {
          users.add((result[i]));
          print(users.length);
        }

        return result.length;
        // {_id: 2, name: Mary, age: 32}
      }
  }

