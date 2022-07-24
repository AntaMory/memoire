
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:waste_time_out/model/user.dart';
import 'package:waste_time_out/sqlite/connexionDB.dart';


class UserService{
  final dbHelper = DatabaseHelper.instance;


  Future<List> getAllUsers() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('user');
    List users = allRows.map((user) => User.fromMap(user)).toList();
    return users;
  }
  // static Future<http.Response> autheticate(String username, String password){
  //   return http.post(
  //
  //       body: jsonEncode({"username" : username, "password": password})
  //   );
  // }

}