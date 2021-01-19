import 'dart:async';
import 'package:new_year_new_me/dao/resolution_dao.dart';
import 'package:new_year_new_me/database/resolution_db.dart';
import 'package:new_year_new_me/model/resolution_model.dart';

class ResolutionRepository implements ResolutionDao {
  final dbProvider = DatabaseProvider.dbProvider;
  var resolutionTable = DatabaseProvider.resolutionTable;
  @override
  Future createResolution(Resolution resolution) async {
    print('the table name here in cr is $resolutionTable ');
    final db = await dbProvider.database;
    var result = db.insert(resolutionTable, resolution.toDatabaseJson());
    return result;
  }

  @override
  Future deleteResolution(int resolutionId) {
      // TODO: implement deleteResolution
      throw UnimplementedError();
    }
  
    @override
    Future updateResolution(int resolutionId) {
    // TODO: implement updateResolution
    throw UnimplementedError();
  }

  @override
  Future fetchAllResolutions() async {
    print('the table name here is $resolutionTable ');
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    result = await db.query(resolutionTable);

    List<Resolution> todos = result.isNotEmpty
        ? result.map((item) => Resolution.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  @override
  void createReslutionTableForAYear() async {
    final db = await dbProvider.database;
    resolutionTable = 'Res2021';
    print('the table name is $resolutionTable ');
    await db.execute("CREATE TABLE $resolutionTable ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "is_done INTEGER "
        ")");
  }


}