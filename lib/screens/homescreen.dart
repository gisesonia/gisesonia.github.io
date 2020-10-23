import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ficha_provider.dart';
import '../models/ficha.dart';
import '../screens/fichas.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fichaProvider = Provider.of<FichaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('FisioControl'),
      ),
      body: StreamBuilder<List<Ficha>>(
          stream: fichaProvider.fichas, //documento do firebase
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing:
                        Icon(Icons.edit, color: Theme.of(context).accentColor),
                    title: Text(
                      formatDate(DateTime.parse(snapshot.data[index].dateStart),
                          [MM, ' ', d, ', ', yyyy]),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FichaScreen(
                                ficha: snapshot.data[index],
                              )));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FichaScreen()));
        },
      ),
    );
  }
}
