import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/sessao.dart';
import '../providers/sessao_provider.dart';



class DetalheSessaoScreen extends StatefulWidget {
  final Sessao sessao;

  DetalheSessaoScreen({this.sessao});
  static const route = '/detalhesessao';

  @override
  _DetalheSessaoScreenState createState() => _DetalheSessaoScreenState();
}

class _DetalheSessaoScreenState extends State<DetalheSessaoScreen> {
  @override
  Widget build(BuildContext context) {
    final sessaoProvider = Provider.of<SessaoProvider>(context);
     var _launchUrl = widget.sessao.exerciseUrl;

   Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Sessão'),
        ),
        body: FutureBuilder(
                future: _launched,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                      child: Text(widget.sessao.pacienteName),
                    );
                  }
                },
              ),
              Container(
          child: Column(
            children: [
               RaisedButton(
                child: const Text('Launch In App'),
                onPressed: () {
                  setState(() {
                    _launched = _launchInBrowser(_launchUrl);
                  });
                },
              ),
            ],
          ),
        ),);
  }
}
