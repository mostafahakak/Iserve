import 'package:cached_network_image/cached_network_image.dart';
import 'package:elsalonapp/Model/MyQuestionModel.dart';
import 'package:elsalonapp/QuestionUser/QuestionUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyQuestions extends StatefulWidget {

  MyQuestions({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyQuestions> {
  List<MyQuestionModel>  userActionList = [];
  DatabaseReference useractRef = FirebaseDatabase.instance.reference().child("Users").child("Mostafa").child("MyQuestions");

  @override
  void initState() {
    super.initState();
    useractRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      for(var individualKey in KEYS)
      {
        MyQuestionModel userAction = new MyQuestionModel(
            DATA[individualKey]['participants'],
            DATA[individualKey]['purpose'],
            DATA[individualKey]['uid']
        );
        userActionList.add(userAction);
        userActionList.sort((a,b)  => b.uid.compareTo(a.uid));

      }
      setState(()
      {
        print('Length : $userActionList.length');
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new StreamBuilder(
          stream:  useractRef.onValue,
          builder: (context, snap) {
            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
              return Scaffold(
                  body: Container(
                    child:SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(children: <Widget>[
                            Container(
                              height: 550,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListView.builder(
                                    itemCount: userActionList.length,
                                    itemBuilder: (_,index)
                                    {
                                      return ExternalUI(
                                          userActionList[index].participants,
                                          userActionList[index].purpose,
                                          userActionList[index].uid
                                      );
                                    }),),)

                          ],)
                        ],
                      ),
                    ),
                  ),
              );
            }
            else
              return Center(child:Text("No Questions asked") ,);

          },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff007944),
        child: Icon(Icons.add),
        onPressed: ()
        {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new QuestionUser()));

        },
      ),
    );
  }

  ExternalUI(String participants,String purpose,String uid)
  {
    return GestureDetector(
      onTap: ()=> {},
      child:  Card(
        color: Colors.white,
        elevation: 10.0,
        margin: EdgeInsets.all(10.0),
        child:  Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 10.0),
              child:ClipRRect(
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                    imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvX367nxF8TkdjvyyipRaH4MuMKW5SLm8pz0vouddmsh4OGoZA&s"),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 30.0),
              child: Container(
                width: 200.0,
                child: Column(
                  children: <Widget>[
                    Text(
                        purpose,
                        style: TextStyle(fontSize:18.0,color: const Color(0xff007944) )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        child:  Text(
                            participants,
                            style: TextStyle(fontSize:12.0, color: const Color(0xff007944))
                        )),
                  ],
                ),
              )
              ,
            ),
          ],
        ),
      ),
    );

  }
}