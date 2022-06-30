import 'package:group28/database/daos/SedentaryDao.dart';
import 'package:group28/database/database.dart';
import 'package:group28/database/entities/pace.dart';
import 'package:group28/database/entities/sedentary.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllPaces() method of the DAO
  Future<List<Pace>> findAllPaces() async {
    final results = await database.paceDao.findAllPaces();
    return results;
  } //findAllPaces

  //This method wraps the insertPace() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertPace(Pace pace) async {
    await database.paceDao.insertPace(pace);
    notifyListeners();
  } //insertPace

  //This method wraps the deletePace() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removePace(Pace pace) async {
    await database.paceDao.deletePace(pace);
    notifyListeners();
  } //removePace

  //This method wraps the updatePace() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updatePace(Pace pace) async {
    await database.paceDao.updatePace(pace);
    notifyListeners();
  } //updatePace

  //var database2 = database;

  //This method wraps the findAllSeds() method of the DAO
  Future<List<Sed>> findAllSeds() async {
    var database2 = database;
    final results = await database2.sedDao.findAllSeds();
    return results;
  } //findAllSeds

  //This method wraps the insertSed() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertSed(Sed sed) async {
    await database.sedDao.insertSed(sed);
    notifyListeners();
  } //insertSed

  //This method wraps the deleteSed() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeSed(Sed sed) async {
    await database.sedDao.deleteSed(sed);
    notifyListeners();
  } //removeSed

  //This method wraps the updateSed() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateSed(Sed sed) async {
    await database.sedDao.updateSed(sed);
    notifyListeners();
  } //updateSed

} //DatabaseRepository
