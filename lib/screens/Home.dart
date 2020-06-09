import 'package:elsalonapp/Model/MyQuestionModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyApps extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApps> {
  final formKey = new GlobalKey<FormState>();
  List<MyQuestionModel>  userActionList = [];

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
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

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          child: Card(
                            child: Wrap(

                            ),
                          ),
                        )
                      ],
                    )),
              ],
            )));

  }

}
