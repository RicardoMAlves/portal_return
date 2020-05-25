import 'package:cloud_firestore/cloud_firestore.dart';

class AcessosMes {

  String id;
  Timestamp dataInicio;
  Timestamp dataFim;
  String refDate;
  int usuariosCadastrados;
  int comDividas;
  int semDividas;

  AcessosMes.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    dataInicio = snapshot.data["DataInicio"];
    dataFim = snapshot.data["DataFim"];
    refDate = snapshot.data["RefDate"];
    usuariosCadastrados = snapshot.data["UsuariosCadastrados"];
    comDividas = snapshot.data["ComDividas"];
    semDividas = snapshot.data["SemDividas"];
  }

}