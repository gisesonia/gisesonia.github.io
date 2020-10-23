import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ficha.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

//Get fichas
  Stream<List<Ficha>> getFichas() {
    return _db.collection('fichas').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Ficha.fromJson(doc.data())).toList());
  }

//Cria ou atualiza as fichas, a variável options checa se é novo ou precisa criar
  Future<void> setFicha(Ficha ficha) {
    var options = SetOptions(merge: true);

    return _db
        .collection('fichas')
        .doc(ficha.fichaId)
        .set(ficha.toMap(), options);
  }

//Deletando
  Future<void> removeFicha(String fichaId) {
    return _db.collection('fichas').doc(fichaId).delete();
  }
}
