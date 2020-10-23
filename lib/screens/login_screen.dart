import 'package:crud_firestore/helpers/validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'FisioControl',
              style: TextStyle(fontSize: 30),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
