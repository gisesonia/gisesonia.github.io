import 'package:flutter/material.dart';

class Ficha {
  final String fichaId;
  final String fisioId;
  final String pacienteId;
  final String dateStart;
  final String dateEnd;
  final String description;
  final String exerciseUrl;

  Ficha(
      {this.fisioId,
      this.pacienteId,
      this.dateStart,
      this.dateEnd,
      this.description,
      this.exerciseUrl,
      @required this.fichaId});

  //função que transforma num objeto dart
  factory Ficha.fromJson(Map<String, dynamic> json) {
    return Ficha(
        fisioId: json['fisioId'],
        pacienteId: json['pacienteId'],
        dateStart: json['dateStart'],
        dateEnd: json['dateEnd'],
        description: json['description'],
        exerciseUrl: json['exerciseUrl'],
        fichaId: json['fichaId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'fichaId': fichaId,
      'fisioId': fisioId,
      'pacienteId': pacienteId,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'exerciseUrl': exerciseUrl,
    };
  }
}
