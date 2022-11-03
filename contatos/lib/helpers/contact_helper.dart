import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/contact.dart';

class ContactHelper {
  Database? _db;

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Future<Database?> get db async {
    return _db ?? await initDb();
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    databasesPath ??= "";
    String dbPath = join(databasesPath, "contacts.db");

    return await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE ${Contact.contactTable}(${Contact.contactId} INTEGER PRIMARY KEY,"
          "${Contact.nameColumn} TEXT, "
          "${Contact.emailColumn} TEXT, "
          "${Contact.phoneColumn} TEXT, "
          "${Contact.imageColumn} TEXT, ");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database? contactDb = await db;
    if (contactDb != null) {
      contact.id =
          await contactDb.insert(Contact.contactTable, contact.toMap());
    }
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database? contactDb = await db;
    if (contactDb != null) {
      List<Map<String, Object?>> map =
          await contactDb.query(Contact.contactTable,
              columns: [
                Contact.contactId,
                Contact.nameColumn,
                Contact.emailColumn,
                Contact.phoneColumn,
                Contact.imageColumn
              ],
              where: "${Contact.contactId} = ?",
              whereArgs: [id]);

      if (map.isNotEmpty) return Contact.fromMap(map.first);
    }
    return null;
  }

  Future<int> deleteContact(int id) async {
    Database? contactDb = await db;
    if (contactDb != null) {
      return await contactDb.delete(Contact.contactTable,
          where: "${Contact.contactId} = ?", whereArgs: [id]);
    }
    return 0;
  }

  Future<int> updateContact(Contact updatedContact) async {
    Database? contactDb = await db;
    if (contactDb != null) {
      return await contactDb.update(
          Contact.contactTable, updatedContact.toMap(),
          where: "${Contact.contactId} = ?", whereArgs: [updatedContact.id]);
    }
    return 0;
  }

  Future<List> getContacts() async {
    Database? contactDb = await db;
    if (contactDb != null) {
      List list = await contactDb.query(Contact.contactTable);
      if (list.isNotEmpty) {
        return list.map((contact) => Contact.fromMap(contact)).toList();
      } else {
        return [];
      }
    }
    return [];
  }
}
