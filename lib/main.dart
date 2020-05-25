import 'package:flutter/material.dart';
import 'package:portalreturn/models/users.dart';
import 'package:portalreturn/pages/homescreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Users>(
      model: Users(),
      child: MaterialApp(
        title: "Portal Return",
        theme:
            new ThemeData(primarySwatch: Colors.red, primaryColor: Colors.red),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
