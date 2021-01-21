import 'package:flutter/material.dart';

import 'model/itemdetails.dart';

class Detailitem extends StatefulWidget {
  final Itemdetail model;
  Detailitem(this.model);
  @override
  _DetailitemState createState() => _DetailitemState();
}

class _DetailitemState extends State<Detailitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFFE65100),
              expandedHeight: 200.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.model.id,
                  child: Image.network('http://192.168.2.115/barter/uploads/' +
                      widget.model.image),
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10.0,
                right: 10.0,
                left: 10.0,
                child: Column(
                  children: <Widget>[
                    Text(widget.model.itemname),
                    Text(widget.model.number),
                    Text(widget.model.tradedesc),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Material(
                        color: Color(0xFFE65100),
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Barter Item",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
