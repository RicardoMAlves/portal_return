import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildAcessos extends StatelessWidget {

  final int _totalAudiences;
  final int _totalAudiencesWithDebts;

  BuildAcessos(this._totalAudiences, this._totalAudiencesWithDebts);

  @override
  Widget build(BuildContext context) {
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
              _totalAudiences.toString(),
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            subtitle: Text(
              "Cadastrados",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18.0),
            ),
            trailing: Text(
                "${_totalAudiencesWithDebts.toString()}\n${(_totalAudiencesWithDebts / _totalAudiences * 100).toStringAsPrecision(3)}%\ncom dívidas",
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
  }
}
