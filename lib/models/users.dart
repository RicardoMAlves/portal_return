import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Model - Guarda o estado da classe em todo App

class Users extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp({@required Map<String, dynamic> userData, @required String pass,
    @required VoidCallback onSucess, @required VoidCallback onFail}) {

    this.isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user;
      await _saveUserData(userData);
      onSucess();
      this.isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      this.isLoading = false;
      notifyListeners();
    });
  }

  void signIn({@required String email, @required String pass,
    @required VoidCallback onSucess, @required VoidCallback onFail}) async {

    this.isLoading = true;
    notifyListeners(); // Notifica todas as páginas que houve alguma alteração
    
    _auth.signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
          firebaseUser = user;
          await _loadCurrentUser();
          onSucess();
          this.isLoading = false;
          notifyListeners();
        }
        ).catchError((e) {
          onFail();
          this.isLoading = false;
          notifyListeners();
        });

  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

}