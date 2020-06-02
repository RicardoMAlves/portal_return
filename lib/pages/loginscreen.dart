import 'package:flutter/material.dart';
import 'package:portalreturn/models/users.dart';
import 'package:portalreturn/pages/signupscreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Arvo",
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Arvo",
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<Users>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-Mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) return "E-mail Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 6 ) return "Senha Inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty)
                          _scaffoldkey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Favor informar o seu email",
                                ),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              )
                          );
                        else {
                          model.recoverPass(_emailController.text);
                          _scaffoldkey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Confira o seu email",
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Arvo",
                            fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSucess: _onSucess,
                            onFail: _onFail);
                      },
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSucess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldkey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Falha no Login",
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
