import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../services/firestore_service.dart';
import '../models/ficha.dart';

class FichaProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _fichaId;
  String _fisioId;
  String _pacienteId;
  DateTime _dateStart;
  DateTime _dateEnd;
  String _description;
  String _exerciseUrl;
  var uuid = Uuid();

  //Getters
  DateTime get dateStart => _dateStart;
  DateTime get dateEnd => _dateEnd;
  String get description => _description;
  String get exerciseUrl => _exerciseUrl;
  Stream<List<Ficha>> get fichas => firestoreService.getFichas();

  //Setters
  set changeFisioId(String value) {
    _fisioId = value;
    notifyListeners();
  }

  set changePacienteId(String value) {
    _pacienteId = value;
    notifyListeners();
  }

  set changeDateStart(DateTime date) {
    _dateStart = dateStart;
    notifyListeners();
  }

  set changeDateEnd(DateTime date) {
    _dateEnd = dateEnd;
    notifyListeners();
  }

  set changeDesc(String value) {
    _description = value;
    notifyListeners();
  }

  set changeExercise(String value) {
    _exerciseUrl = value;
    notifyListeners();
  }

//Funções
  loadAll(Ficha ficha) {
    if (ficha != null) {
      _fisioId = ficha.fisioId;
      _pacienteId = ficha.pacienteId;
      _dateStart = DateTime.parse(ficha.dateStart);
      _dateEnd = DateTime.parse(ficha.dateEnd);
      _description = ficha.description;
      _exerciseUrl = ficha.exerciseUrl;
      _fichaId = ficha.fichaId;
    } else {
      _fisioId = null;
      _pacienteId = null;
      _dateStart = DateTime.now();
      _dateEnd = DateTime.now();
      _description = null;
      _exerciseUrl = null;
      _fichaId = null;
    }
  }

  saveFicha() {
    print("$_dateStart,$_dateEnd");
    //Adiciona
    if (_fichaId == null) {
      var novaFicha = Ficha(
          fisioId: _fisioId,
          pacienteId: _pacienteId,
          dateStart: _dateStart.toIso8601String(),
          dateEnd: _dateEnd.toIso8601String(),
          description: _description,
          exerciseUrl: _exerciseUrl,
          fichaId: uuid.v1());
      firestoreService.setFicha(novaFicha);
      //print(novaFicha.toMap().toString());
    } else {
      //Atualiza a ficha
      var updateFicha = Ficha(
          fisioId: _fisioId,
          pacienteId: _pacienteId,
          dateStart: _dateStart.toIso8601String(),
          dateEnd: _dateEnd.toIso8601String(),
          description: _description,
          exerciseUrl: _exerciseUrl,
          fichaId: _fichaId);
      firestoreService.setFicha(updateFicha);
    }
  }

//Deleta a ficha
  removeFicha(String fichaId) {
    firestoreService.removeFicha(fichaId);
  }
}
