import 'package:flutter/material.dart';
import 'package:portalreturn/pages/homekpis.dart';
import 'package:portalreturn/pages/homescreen.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (this.text == "Inicio")
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
          if (this.text == "Portal Ipanema")
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context)=>
                        HomeKpis(
                          dayStart: 0,
                          dayEnd: 0,
                          monthSelected: 0,
                          yearSelected: 0,
                        )
                )
            );
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(width: 32.0,),
              Text(
                this.text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
