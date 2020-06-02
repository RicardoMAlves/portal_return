import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDAcessos extends StatelessWidget {

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore Demo'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),
              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Update Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),
            ],
          )), //center
    );
  }

  void createRecord() async {
    await databaseReference.collection("acessosmes")
        .document("jun2020")
        .setData({
      'ComDividas': 350,
      'DataFim': 30/06/2020,
      'DataInicio': 01/06/2020,
      'RefDate': '202006',
      'SemDividas': 2000,
      'UsuariosCadastrados': 2350
    });

    /*DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });*/

    print(databaseReference.collection("acessosmes").document("jun2020"));
  }

  void getData() {
    databaseReference
        .collection("acessosmes")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
    print("");
    databaseReference
        .collection("acessosmes").document("mai2020").collection("diasdomes")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('acessosmes')
          .document('jun2020')
          .updateData({'SemDividas': 0});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference
          .collection('acessosmes')
          .document('jun2020')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
