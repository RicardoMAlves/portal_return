import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portalreturn/models/diasdomes.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:portalreturn/utils/utilsdate.dart';

// ignore: must_be_immutable
class BuildChartAcessos extends StatelessWidget {

  final List<DiasDoMes> _listDiasDoMes = [];

  final int _dayStart;
  final int _dayEnd;
  final int _refDate;
  
  UtilsDate utilsDate = UtilsDate();

  String _monthSelected;

  BuildChartAcessos(this._dayStart, this._dayEnd ,this._refDate);

  @override
  Widget build(BuildContext context) {

    _monthSelected = utilsDate.monthReduceExtension(int.parse(_refDate.toString().substring(4,6))-1);

    return Center(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("Audiences")
            .where("RefDate", isEqualTo: this._refDate)
            .where("DayTransaction", isGreaterThanOrEqualTo: this._dayStart, isLessThanOrEqualTo: this._dayEnd)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          snapshot.data.documents.forEach((element) {
            _listDiasDoMes.add(DiasDoMes(
                diaDoMes: element.data["DayTransaction"],
                clientesCadastrados: element.data["TotalAudiences"],
                barColor: charts.ColorUtil.fromDartColor(Colors.blue)));
          });
          List<charts.Series<DiasDoMes, String>> series = [
            charts.Series(
                id: "Clientes",
                data: _listDiasDoMes,
                domainFn: (DiasDoMes series, _) => series.diaDoMes.toString(),
                measureFn: (DiasDoMes series, _) => series.clientesCadastrados,
                colorFn: (DiasDoMes series, _) => series.barColor)
          ];
          return Container(
            width: 600.0,
            height: 400.0,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Acessos em $_monthSelected",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "Arvo",
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: charts.BarChart(series, animate: true),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
