import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../model/Transactions.dart';

class TransactionDB {
  String dbname;

  TransactionDB({required this.dbname});

  Future<Database> openDatabase() async {
    //find store
    Directory appDirectory = await getApplicationCacheDirectory();
    String dbLocation = join(appDirectory.path, dbname);
    //create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }
  //save data

  Future<int> insertData(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("express");
    //json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  //create method pull data
  Future<bool> loadAllDta() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db);

    print(snapshot);
    return true;
  }
}
