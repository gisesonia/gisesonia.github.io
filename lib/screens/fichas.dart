import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ficha.dart';
import '../providers/ficha_provider.dart';

class FichaScreen extends StatefulWidget {
  final Ficha ficha;

  FichaScreen({this.ficha});

  @override
  _FichaScreenState createState() => _FichaScreenState();
}

class _FichaScreenState extends State<FichaScreen> {
  final nameController = TextEditingController();
  final fisioController = TextEditingController();
  final pacienteIdController = TextEditingController();
  final descriptionController = TextEditingController();
  final exerciseUrlController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    fisioController.dispose();
    pacienteIdController.dispose();
    descriptionController.dispose();
    exerciseUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final fichaProvider = Provider.of<FichaProvider>(context, listen: false);
    if (widget.ficha != null) {
      //Edita
      fisioController.text = widget.ficha.fisioId;
      fisioController.text = widget.ficha.fisioId;
      pacienteIdController.text = widget.ficha.pacienteId;
      descriptionController.text = widget.ficha.description;
      exerciseUrlController.text = widget.ficha.exerciseUrl;

      fichaProvider.loadAll(widget.ficha);
    } else {
      //Adiciona
      fichaProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fichaProvider = Provider.of<FichaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Texto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'ID do Fisioterapeuta', hintText: '0000'),
              onChanged: (String value) => fichaProvider.changeFisioId = value,
              controller: fisioController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'ID do Paciente', hintText: '0000'),
              onChanged: (String value) =>
                  fichaProvider.changePacienteId = value,
              controller: pacienteIdController,
            ),
            Text('Data início'),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _pickDate(context, fichaProvider).then((value) {
                  if (value != null) {
                    fichaProvider.changeDateStart = value;
                  }
                });
              },
            ),
            Text('Data término'),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _pickDate(context, fichaProvider).then((value) {
                  if (value != null) {
                    fichaProvider.changeDateEnd = value;
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) => fichaProvider.changeDesc = value,
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'URL do vídeo do youtube',
                  hintText: 'http://www.youtube.com.br/'),
              onChanged: (String value) => fichaProvider.changeExercise = value,
              controller: exerciseUrlController,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () {
                fichaProvider.saveFicha();
                Navigator.of(context).pop();
              },
            ),
            (widget.ficha != null)
                ? RaisedButton(
                    color: Colors.red,
                    child:
                        Text('Delete', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      fichaProvider.removeFicha(widget.ficha.fichaId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<DateTime> _pickDate(
      BuildContext context, FichaProvider fichaProvider) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));

    if (picked != null) {
      return picked;
    }
  }
}
