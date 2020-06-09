import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://firebasestorage.googleapis.com/v0/b/nitrous-c7d4f.appspot.com/o/Images%2FUsers%2FAdmin%2F1589624234992.jpg?alt=media&token=4a2ea1c0-3bd6-43b4-a300-4e41ac842f0f';

    return new Scaffold(
        backgroundColor: Colors.grey,
        body: new Center(
          child: new ListView(
            children: <Widget>[
              new SizedBox(height: _height/12,),
              new Center(child: CircleAvatar(radius:_width<_height? _width/4:_height/4,backgroundImage: NetworkImage(imgUrl),),),
              new SizedBox(height: _height/35.0,),
              new Padding(padding: new EdgeInsets.only(left: _width/3, right: _width/3), child: new FlatButton(onPressed: (){},
                child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                  new Icon(Icons.person),
                  new SizedBox(width: _width/30,),
                  new Text('Edit')
                ],)),color: Colors.blue[50],),),
              new SizedBox(height: _height/35.0,),
              new Center(child: Text('Mostafa Ashraf', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width/15, color: const Color(0xff007944)),),),
              new Divider(height: _height/30,color: const Color(0xff007944),),
              new Row(
                children: <Widget>[
                  rowCell(0, 'POSTS',),
                  new Divider(color: Colors.white,),
                  rowCell(0, 'Answered'),
                  new Divider(color: Colors.white,),
                  rowCell(0, 'Open'),
                ],),
              new Divider(height: _height/30,color: Colors.white),
              new Padding(padding: new EdgeInsets.only(top: _height/30, left: _width/8, right: _width/8),
                child:new Text('+02 01282160015 ',
                  style: new TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: const Color(0xff007944)),textAlign: TextAlign.center,) ,),
              new Padding(padding: new EdgeInsets.only(top: _height/30, left: _width/8, right: _width/8),
                child:new Text('We can add any info here :) ',
                  style: new TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: const Color(0xff007944)),textAlign: TextAlign.center,) ,),
            ],
          ),
        )
    );
  }

  Widget rowCell(int count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.white),),
    new Text(type,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
  ],));
}