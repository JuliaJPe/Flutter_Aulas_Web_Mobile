import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// Nome dos campos na tabela do banco de dados, por isso são constantes
final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";

class DatabaseProvider {
  static DatabaseProvider get _instance => DatabaseProvider.internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider.internal() {}
  late Database _db;

  Future<Database> get db async {
    _db = await initDb();
    debugPrint("Instancia de banco de dados = ${_db.isOpen}");
    return _db;

    /**if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
    */
  }

  Future<Database> initDb() async {
    //final databasesPath = await getDatabasesPath();
    //final path = join(databasesPath, "contactsnew.db");

    return await openDatabase('contactsnovo.db', version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $nameColumn TEXT, $emailColumn TEXT,"
          "$phoneColumn TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    Map<String, Object> data = contact.toMap();
    data.remove("idColumn");
    contact.id = await dbContact.insert(contactTable, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    var contact2 = contact;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }
}

class Contact {
  int id = -1;
  String name = "";
  String email = "";
  String phone = "";

  Contact();

  // Construtor que converte os dados de mapa (JSON) para objeto do contato
  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
  }

  // Método que transforma o objeto do contato em Mapa (JSON) para armazenar no banco de dados
  Map<String, Object> toMap() {
    Map<String, Object> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      idColumn: id
    };

    return map;
  }
}
