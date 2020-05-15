import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:carshop/member.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usr = new TextEditingController();
  TextEditingController psw = new TextEditingController();
  String msg='';

  Future<String> _login() async {
    final response = await http.post("http://192.168.43.58/apicarshop/login/login_api", body:{
      "username":usr.text,
      "password":psw.text,
    });

    var datauser=json.decode(response.body);

    if(datauser['error']==true){
      setState(() {
        msg=datauser['msg'];
      });
    } else {
      String emailAPI=datauser['email'];
      String namaAPI=datauser['nama'];
      String id=datauser['id'];
      String photo=datauser['photo'];
      int level = int.parse(datauser['level']);

      setState(() {
        savePref(emailAPI,namaAPI,id,level,photo);
        msg=datauser['msg'];
      });

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context)=>Member()
      ));
    }
  }

  savePref(String email, String nama, String id, int level, String photo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("nama", nama);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.setString("photo", photo);
      preferences.setInt("level", level);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login/bg_login.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  new Image.asset(
                    'assets/login/login.png',
                    width: 150,
                  ),
                  new Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          controller: usr,
                          decoration: InputDecoration(
                            hintText: "Username",
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),

                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        new TextField(
                          obscureText: true,
                          controller: psw,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),

                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        new RaisedButton(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // new Icon(Icons.verified_user),
                              new Text("LOGIN")
                            ],
                          ),
                          color: Colors.blue,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            _login();
                          },
                        ),
                        
                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        Text(
                          msg,
                          style: new TextStyle(fontSize: 20.0,color: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}