import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portalreturn/models/acessosmes.dart';

class BuildPeriodoAnalisado extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;

  AcessosMes acessosMes;

  BuildPeriodoAnalisado(this.snapshot);

  @override
  Widget build(BuildContext context) {
    acessosMes = AcessosMes.fromDocument(snapshot.data.documents[0]);
    return Center(
      child: Card(
        child: Container(
          width: 600.0,
          height: 70.0,
          child: ListTile(
            leading: Icon(
              Icons.date_range,
              size: 50.0,
              color: Colors.red,
            ),
            title: Text(
              "Período Analisado:",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            subtitle: Text(
              "${acessosMes.dataInicio.toDate().day.toString()} à ${acessosMes.dataFim.toDate().day.toString()}/${acessosMes.dataFim.toDate().month.toString()}",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}
