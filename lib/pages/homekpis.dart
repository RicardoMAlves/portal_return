import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portalreturn/widgets/buildacessos.dart';
import 'package:portalreturn/widgets/buildperiodoanalisado.dart';
import 'package:portalreturn/widgets/customdrawer.dart';

class HomeKpis extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[
          FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("acessosmes").getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                );
              } else
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      BuildPeriodoAnalisado(snapshot),
                      Divider(),
                      BuildAcessos(snapshot),
                      Divider(),
                    ],
                  ),
                );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}