import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _secureText = true;
  String email, password, name;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    debugPrint("Success");
    final response =
        await http.post("http://192.168.2.115/barter/register.php", body: {
      'email': email,
      'password': password,
      'name': name,
    });

    debugPrint(response.body.toString());
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    debugPrint(data.toString());
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      loginToast(message);
    } else {
      print(message);
      failedToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'You Have Sucessfully Register',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Account Already Exists',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
          backgroundColor: Color(0xFFE65100),
        ),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0, 50.0, 0.0, 0.0),
                                    child: Material(
                                      child: Image.asset(
                                        'assets/images/logo1.png',
                                        width: 350,
                                        height: 180,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert email";
                              }
                              return null;
                            },
                            onSaved: (e) => email = e,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.mail),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert password";
                              }
                              return null;
                            },
                            obscureText: _secureText,
                            onSaved: (e) => password = e,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Full name";
                              }
                              return null;
                            },
                            onSaved: (e) => name = e,
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                suffixIcon: Icon(Icons.edit),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            width: 300,
                            height: 50.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Color(0xff083663),
                              color: Color(0xFFE65100),
                              elevation: 7.0,
                              child: MaterialButton(
                                onPressed: () {
                                  check();
                                },
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
