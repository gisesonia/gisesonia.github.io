import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sessao.dart';
import '../providers/sessao_provider.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    var url = sessaoProvider.exerciseUrl;

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Sessão'),
        ),
        body: Container(
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                liveUIColor: Colors.amber,
              ),
            ],
          ),
        ));
  }
}
