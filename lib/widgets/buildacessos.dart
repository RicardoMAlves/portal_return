import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildAcessos extends StatelessWidget {

  final AsyncSnapshot<QuerySnapshot> snapshot;

  BuildAcessos(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 600.0,
          height: 100.0,
          child: Text(
            "Acessos",
            style: TextStyle(
                fontFamily: "Arvo",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
