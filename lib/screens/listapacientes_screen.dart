import 'package:flutter/material.dart';

class PacientesFisioScreen extends StatefulWidget {
  PacientesFisioScreen({Key key}) : super(key: key);

  @override
  _PacientesFisioScreenState createState() => _PacientesFisioScreenState();
}

class _PacientesFisioScreenState extends State<PacientesFisioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes cadastrados'),
      ),
      body: Container(
        child: Text('Lista de pacientes'),
      ),
    );
  }
}
