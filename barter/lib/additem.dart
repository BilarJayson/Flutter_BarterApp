import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Additem extends StatefulWidget {
  // final VoidCallback reload;
  // Additem(this.reload);
  @override
  _AdditemState createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  String itemname, number, tradedesc, idUser;
  final _key = new GlobalKey<FormState>();
  File _imageFile;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = preferences.getString("id");
    });
  }

  _pickgallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1920.0,
      maxWidth: 1080.0,
    );
    setState(() {
      _imageFile = image;
    });
  }

  submit() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse("http://192.168.2.115/barter/additem.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['itemname'] = itemname;
      request.fields['number'] = number;
      request.fields['tradedesc'] = tradedesc;
      request.fields['idUser'] = idUser;

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        setState(() {
          Navigator.pop(context);
        });
        Fluttertoast.showToast(
            msg: 'Item Successfully  Added',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white);
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  addToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Item Successfully  Added',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Failed to Add Record',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('assets/images/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Color(0xFFE65100),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180.0,
              child: InkWell(
                onTap: () {
                  _pickgallery();
                },
                child: _imageFile == null
                    ? placeholder
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              onSaved: (e) => itemname = e,
              decoration: InputDecoration(labelText: 'Item name'),
            ),
            TextFormField(
              onSaved: (e) => number = e,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextFormField(
              onSaved: (e) => tradedesc = e,
              decoration: InputDecoration(labelText: 'Trade Description'),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50.0,
              width: 50,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Add Item',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
