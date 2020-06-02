import 'package:cloud_firestore/cloud_firestore.dart';

class Audiences {

  String id;
  String transactionDate;
  int refDate;
  int dayTransaction;
  int totalAudiences;
  int totalAudiencesWithDebts;

  Audiences.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    transactionDate = snapshot.data["TransactionDate"];
    refDate = snapshot.data["RefDate"];
    dayTransaction = snapshot.data["DayTransaction"];
    totalAudiences = snapshot.data["TotalAudiences"];
    totalAudiencesWithDebts = snapshot.data["TotalAudiencesWithDebts"];
  }

}