import 'package:group28/database/entities/pace.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class PaceDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Pace table
  @Query('SELECT * FROM Pace')
  Future<List<Pace>> findAllPaces();

  //Query #2: INSERT -> this allows to add a Pace in the table
  @insert
  Future<void> insertPace(Pace pace);

  //Query #3: DELETE -> this allows to delete a Pace from the table
  @delete
  Future<void> deletePace(Pace task);

  //Query #4: UPDATE -> this allows to update a Pace entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePace(Pace pace);
  
}//paceDao