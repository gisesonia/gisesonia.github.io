import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/firebase_erros.dart';
import '../models/user_fisio.dart';

class UserFisioManager extends ChangeNotifier {
  UserFisioManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserFisio user; //Usuário do firebase

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  bool admin = true;

  Future<void> signIn(
      {UserFisio userfisio, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: userfisio.email,
          password: userfisio.password); //Usuário da classe user.dart

      await _loadCurrentUser(firebaseUser: result.user); //

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {UserFisio userfisio, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: userfisio.email, password: userfisio.password);

      userfisio.id = result.user.uid;
      this.user = user;

      //print(result);

      await userfisio.saveData(); //salva os dados do usuário

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = await firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      //user = currentUser;
      //print(user.uid);
      final DocumentSnapshot docUser = await firestore
          .collection('fisioterapeutas')
          .doc(currentUser.uid)
          .get();
      user = UserFisio.fromDocument(docUser);

      final docAdmin =
          await firestore.collection('fisioterapeutas').doc(user.id).get();
      if (docAdmin.exists) {
        user.admin = true;
      }

      print(user.admin);

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;
}
