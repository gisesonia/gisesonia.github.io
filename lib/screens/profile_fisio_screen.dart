import 'package:crud_firestore/models/userfisio_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFisioScreen extends StatefulWidget {
  ProfileFisioScreen({Key key}) : super(key: key);

  @override
  _ProfileFisioScreenState createState() => _ProfileFisioScreenState();
}

class _ProfileFisioScreenState extends State<ProfileFisioScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserFisioManager>(
        builder: (_, userManager, __) {
          if (userManager.adminEnabled) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Meu cadastro',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Olá, ${userManager.user?.name ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed('fisiologin');
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child:
                  Text('Você não é fisioterapeuta, acesse a área de paciente'),
            );
          }
        },
      ),
    );
  }
}
