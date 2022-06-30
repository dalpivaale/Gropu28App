import 'package:group28/database/entities/sedentary.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class SedDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Sed table
  @Query('SELECT * FROM Sed')
  Future<List<Sed>> findAllSeds();

  //Query #2: INSERT -> this allows to add a Sed in the table
  @insert
  Future<void> insertSed(Sed sed);

  //Query #3: DELETE -> this allows to delete a Sed from the table
  @delete
  Future<void> deleteSed(Sed seddelete);

  //Query #4: UPDATE -> this allows to update a Sed entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSed(Sed sed);
}//sedDao