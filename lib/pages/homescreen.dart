import 'package:flutter/material.dart';
import 'package:portalreturn/widgets/customdrawer.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "Return Capital",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Arvo",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: Center(
              child: Image.asset(
                "images/Return2.png",
                fit: BoxFit.none,
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }

}
