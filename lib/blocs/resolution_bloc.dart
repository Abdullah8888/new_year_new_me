


import 'dart:async';
import 'package:new_year_new_me/database/resolution_db.dart';
import 'package:new_year_new_me/model/resolution_model.dart';
import 'package:new_year_new_me/repository/resolution_repository.dart';
import 'package:sqflite/sqflite.dart';

class ResolutionBloc {
  //Get instance of the Repository
  final _resolutionRepository = ResolutionRepository();
  final _dbProviderTest = DatabaseProvider.dbProvider;

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers

  final _resolutionController = StreamController<List<Resolution>>.broadcast();
  //final _resolutionController = StreamController<dynamic>.broadcast();

  get resolutions => _resolutionController.stream;

  ResolutionBloc() {
    fetchResolutions();
  }

  fetchResolutions({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _resolutionController.sink.add(await _resolutionRepository.fetchAllResolutions());
  }

  createResolution(Resolution resolution) async {
    await _resolutionRepository.createResolution(resolution);
    fetchResolutions();
  }

  createResTable() async {
    await _resolutionRepository.createReslutionTableForAYear();
  }


  dispose() {
    _resolutionController.close();
  }
}