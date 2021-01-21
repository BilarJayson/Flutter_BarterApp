import 'dart:convert';

import 'package:barter/model/itemdetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Edititem extends StatefulWidget {
  final Itemdetail model;
  final VoidCallback reload;
  Edititem(this.model, this.reload);
  @override
  _EdititemState createState() => _EdititemState();
}

class _EdititemState extends State<Edititem> {
  final _key = new GlobalKey<FormState>();
  String itemname, number, tradedesc;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response =
        await http.post('http://192.168.2.115/barter/edititem.php', body: {
      'itemname': itemname,
      'tradedesc': tradedesc,
      'idUser': widget.model.id,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: 'Record successfully updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: 'Fail to update the record',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Color(0xffb5171d),
          textColor: Colors.white);
      String message = data['message'];
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Edit Item record",
        ),
        backgroundColor: Color(0xFFE65100),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Edit Item',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    autocorrect: true,
                    onSaved: (e) => itemname = e,
                    decoration: InputDecoration(
                        labelText: 'Item name ',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff083663),
                        )),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    autocorrect: true,
                    onSaved: (e) => tradedesc = e,
                    decoration: InputDecoration(
                        labelText: 'Trade Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff083663),
                        )),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50,
                  width: 250,
                  child: RaisedButton(
                    onPressed: () {
                      check();
                    },
                    color: Color(0xFFE65100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Edit Record',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
