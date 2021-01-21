import 'package:barter/additem.dart';
import 'package:barter/edititem.dart';
import 'package:barter/profile.dart';
import 'package:barter/viewitem.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'displayitem.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;
  Home(this.signOut);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String email = "", name = "";
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("email");
      name = preferences.getString("name");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpref();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barter'),
        backgroundColor: Color(0xFFE65100),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("$name", style: TextStyle(fontSize: 20.0)),
              accountEmail: Text("$email", style: TextStyle(fontSize: 20.0)),
              decoration: BoxDecoration(color: Color(0xFFE65100)),
            ),
            Divider(),
            // ListTile(
            //   title: Text('Profiles', style: TextStyle(fontSize: 20.0)),
            //   trailing: Icon(Icons.account_circle),
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) => Profile()));
            //   },
            // ),
            Divider(),
            ListTile(
              title: Text('Sign out', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                signOut();
                Fluttertoast.showToast(
                    msg: 'You Have Sucessfully Logout',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Barter ',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 60.0,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Color(0xff083663),
                color: Color(0xFFE65100),
                elevation: 7.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Additem()));
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_to_home_screen,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text('Add item',
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
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60.0,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Color(0xff083663),
                color: Color(0xFFE65100),
                elevation: 7.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Item()));
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.library_books,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text('Edit items',
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
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60.0,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Color(0xff083663),
                color: Color(0xFFE65100),
                elevation: 7.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Displayitem()));
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text('Display Barter Items',
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
