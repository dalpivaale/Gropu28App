//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:group28/database/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Here, we are importing the entities and the daos of the database
import 'package:group28/database/daos/paceDao.dart';
import 'package:group28/database/entities/pace.dart';
import 'package:group28/database/daos/sedentaryDao.dart';
import 'package:group28/database/entities/sedentary.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has 2 entities,Pace and Sed.
//We also added a TypeConverter to manage the DateTime of a Goal entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Pace, Sed])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  PaceDao get paceDao;
  SedDao get sedDao;
} //AppDatabase
