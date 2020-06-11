import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portalreturn/utils/utilsdate.dart';

// ignore: must_be_immutable
class BuildAudiencesWithDebts extends StatelessWidget {

  final int _totalAudiencesWithDebts;

  int _totalDebts = 0;
  double _totalAmountOpenDebts = 0.0;

  UtilsDate utilsDate = UtilsDate();

  BuildAudiencesWithDebts(this._totalAudiencesWithDebts);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("AudiencesWithDebts")
            .where("RefDate", isEqualTo: utilsDate.refDateSystemDate())
            .orderBy("DayTransaction")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          snapshot.data.documents.forEach((element) {
            _totalDebts = _totalDebts + element.data["TotalDebts"];
            _totalAmountOpenDebts = _totalAmountOpenDebts + element.data["CurrentOpenBalance"];
          });
          return Center(
            child: Container(
              width: 600.0,
              height: 100.0,
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    size: 50.0,
                    color: Colors.red,
                  ),
                  title: Text(
                    _totalAudiencesWithDebts.toString(),
                    style: TextStyle(
                        fontFamily: "Arvo",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "Cliente com Dívidas",
                    style: TextStyle(
                        fontFamily: "Arvo",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18.0),
                  ),
                  trailing: Text(
                    "$_totalDebts Dívidas\nde BRL ${_totalAmountOpenDebts.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontFamily: "Arvo",
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
