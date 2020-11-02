import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sessao.dart';

//Essa classe serve de comunicação com a coleção criada no banco firestore

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

//Get sessoes - busca as sessoes cadastradas no firebase
  Stream<List<Sessao>> getSessoes() {
    return _db.collection('sessoes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Sessao.fromJson(doc.data())).toList());
  }

//Cria ou atualiza as sessoes, a variável options checa se é novo ou precisa criar
  Future<void> setSessao(Sessao sessao) {
    var options = SetOptions(merge: true);
//retorna a coleção sessoes criada no banco cloud firestore pelo Id, toMap transforma em mapa do dart
    return _db
        .collection('sessoes')
        .doc(sessao.sessaoId)
        .set(sessao.toMap(), options);
  }

//Deletando uma sessao pelo Id
  Future<void> removeSessao(String sessaoId) {
    return _db.collection('sessoes').doc(sessaoId).delete();
  }
}
