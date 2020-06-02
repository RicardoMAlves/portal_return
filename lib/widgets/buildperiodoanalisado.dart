import 'package:flutter/material.dart';

class BuildPeriodoAnalisado extends StatelessWidget {

  final int _dayStart;
  final int _dayEnd;
  final String _month;

  BuildPeriodoAnalisado(this._dayStart, this._dayEnd, this._month);

  @override
  Widget build(BuildContext context) {
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
              "${_dayStart.toString()} à ${_dayEnd.toString()}/$_month",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18.0),
            ),
            trailing: Icon(
              Icons.filter_list,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
