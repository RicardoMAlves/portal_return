import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portalreturn/models/audiences.dart';
import 'package:portalreturn/models/users.dart';
import 'package:portalreturn/widgets/buildacessos.dart';
import 'package:portalreturn/widgets/buildaudienceswithdebts.dart';
import 'package:portalreturn/widgets/buildchartacessos.dart';
import 'package:portalreturn/widgets/buildperiodoanalisado.dart';
import 'package:portalreturn/widgets/customdrawer.dart';
import 'package:portalreturn/utils/utilsdate.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeKpis extends StatefulWidget {
  final int dayStart;
  final int dayEnd;
  final int monthSelected;
  final int yearSelected;

  HomeKpis(
      {@required this.dayStart,
      @required this.dayEnd,
      @required this.monthSelected,
      @required this.yearSelected});

  @override
  _HomeKpisState createState() => _HomeKpisState();
}

class _HomeKpisState extends State<HomeKpis> {
  Audiences audiences;

  UtilsDate utilsDate = UtilsDate();

  int _dayStart;
  int _dayEnd;
  int _refDateSearch;
  int _totalAudiences = 0;
  int _totalAudiencesWithDebts = 0;
  String _month;

  @override
  Widget build(BuildContext context) {
    _refDateSearch = (widget.monthSelected == 0 && widget.yearSelected == 0)
        ? int.parse(utilsDate.refDateSystemDate())
        : int.parse(widget.yearSelected.toString() +
            utilsDate.monthNumeric(widget.monthSelected));

    _dayStart = (widget.dayStart == 0) ? 1 : widget.dayStart;
    _dayEnd = (widget.dayEnd == 0) ? 31 : widget.dayEnd;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "Portal Ipanema",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Arvo",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ScopedModelDescendant<Users>(
        builder: (context, child, model) {
          if (!model.isLoggedIn()) {
            final snackBar = SnackBar(
              content: Text(
                "Falha no Login",
              ),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 2),
            );
            Navigator.of(context).pop();
          }
          return ListView(
            children: <Widget>[
              FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("Audiences")
                    .where("RefDate", isEqualTo: _refDateSearch)
                    .where("DayTransaction", isGreaterThanOrEqualTo: _dayStart, isLessThanOrEqualTo: _dayEnd)
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    );
                  }
                  audiences =
                      Audiences.fromDocument(snapshot.data.documents.first);
                  _dayStart = audiences.dayTransaction;
                  audiences =
                      Audiences.fromDocument(snapshot.data.documents.last);
                  _dayEnd = audiences.dayTransaction;
                  _month = utilsDate.monthReduceExtension(
                      int.parse(audiences.transactionDate.substring(3, 5)) - 1);
                  snapshot.data.documents.forEach((element) {
                    _totalAudiences =
                        _totalAudiences + element.data["TotalAudiences"];
                    _totalAudiencesWithDebts = _totalAudiencesWithDebts +
                        element.data["TotalAudiencesWithDebts"];
                  });
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        BuildPeriodoAnalisado(_dayStart, _dayEnd, _month),
                        Divider(),
                        BuildAcessos(_totalAudiences, _totalAudiencesWithDebts),
                        Divider(),
                        BuildChartAcessos(_dayStart, _dayEnd, _refDateSearch),
                        //Divider(),
                        //BuildAudiencesWithDebts(_totalAudiencesWithDebts),
                        //Divider(),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
      drawer: CustomDrawer(),
    );
  }
}
