import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class BuildPeriodoAnalisado extends StatefulWidget {

  final int _dayStart;
  final int _dayEnd;
  final String _month;

  BuildPeriodoAnalisado(this._dayStart, this._dayEnd, this._month);

  @override
  _BuildPeriodoAnalisadoState createState() => _BuildPeriodoAnalisadoState();
}

class _BuildPeriodoAnalisadoState extends State<BuildPeriodoAnalisado> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 600.0,
          height: 70.0,
          child: ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.date_range,
                size: 50.0,
                color: Colors.red,
              ),
              onPressed: () async {
                final List<DateTime> picked =
                    await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate: new DateTime.now(),
                        initialLastDate:
                            (new DateTime.now()).add(new Duration(days: 7)),
                        firstDate: new DateTime(2019),
                        lastDate: new DateTime(2021));
                if (picked != null && picked.length == 2) {
                }
              },
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
              "${widget._dayStart.toString()} à ${widget._dayEnd.toString()}/${widget._month}",
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
