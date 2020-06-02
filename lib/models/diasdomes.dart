import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DiasDoMes {

  final int diaDoMes;
  final int clientesCadastrados;
  final charts.Color barColor;


  DiasDoMes({
    @required this.diaDoMes,
    @required this.clientesCadastrados,
    @required this.barColor
  });

}