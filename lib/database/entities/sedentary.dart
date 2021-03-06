import 'package:floor/floor.dart';

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Sed {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //The max value the user want to be seated in a day
  final double minsed;

  //When the goal occured
  final DateTime dateTime;

  //Default constructor
  Sed(this.id, this.minsed, this.dateTime);
} //Sedentary 
