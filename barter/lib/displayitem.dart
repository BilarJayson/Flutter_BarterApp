import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailitem.dart';
import 'model/itemdetails.dart';

class Displayitem extends StatefulWidget {
  @override
  _DisplayitemState createState() => _DisplayitemState();
}

class _DisplayitemState extends State<Displayitem> {
  var loading = false;
  final list = new List<Itemdetail>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.get("http://192.168.2.115/barter/read.php");
    debugPrint(response.body);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new Itemdetail(
          api['id'],
          api['itemname'],
          api['number'],
          api['tradedesc'],
          api['image'],
        );

        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Display Items'),
        backgroundColor: Color(0xFFE65100),
      ),
      body: Container(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Detailitem(x)));
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Hero(
                            tag: x.id,
                            child: Image.network(
                              'http://192.168.2.115/barter/uploads/' + x.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          x.itemname,
                          textAlign: TextAlign.center,
                        ),
                        Text(x.number),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
