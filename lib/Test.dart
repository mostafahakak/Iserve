import 'package:carousel_slider/carousel_slider.dart';
import 'package:elsalonapp/Model/CorsModel.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';

 List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


class Test extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Test> {
  List<CorsModel>  CrossList = [];

  void initState() {
    super.initState();

    DatabaseReference useractRef = FirebaseDatabase.instance.reference().child("UsersAction");
    useractRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      CrossList.clear();

      for(var individualKey in KEYS)
      {
        CorsModel userAction = new CorsModel(
            DATA[individualKey]['info'],
          DATA[individualKey]['image'],
          DATA[individualKey]['order'],
        );
        CrossList.add(userAction);
        CrossList.sort((a,b)  => b.order.compareTo(a.order));

      }
      setState(()
      {
        print('Length : $CrossList.length');
      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(
        children: [
          Container(
              child: Column(children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                ),
                Container(
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 25.0, right: 170.0,left: 10.0) ,
                    child:  Text("Categories",  style: TextStyle(fontWeight: FontWeight.w700),),),
                    Padding(padding: EdgeInsets.only(top: 5.0, right: 30.0,left: 30.0) ,
                      child:  Divider(color: Colors.black,),
                    ),
                    StreamBuilder( stream: FirebaseDatabase.instance
                        .reference().child("Categories").child("Info")
                        .onValue,
                        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.snapshot.value != null) {
                              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                              List<dynamic> list = map.values.toList()
                                ..sort(
                                        (a, b) => b['image'].compareTo(a['image']));
                              //    list[index]["image"]
                              return new Row(children: <Widget>[Expanded(
                                child: SizedBox(
                                  height: 300.0
                                  ,child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.1,
                                      crossAxisCount: 2),
                                  itemCount: list.length,
                                  padding: EdgeInsets.all(2.0),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.0,left: 10.0),
                                      child: Card(
                                        child:
                                        Column(children: <Widget>[
                                          InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                  imageUrl:
                                                  list[index]["image"]),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 5.0),
                                            child: Text(list[index]["name"])
                                            ,)
                                        ],),
                                      ),
                                    );
                                  },
                                ),
                                ),
                              )],
                              );
                            } else {
                              return Container(
                                  child: Center(
                                      child: Text(
                                        'No Data.',
                                        style: TextStyle(fontSize: 20.0, color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      )));
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                    )

                  ],),
                ),
              ],)
          ),
        ],
      ),
    );

  }
  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();


}








