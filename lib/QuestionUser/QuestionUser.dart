import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionUser extends StatefulWidget {


  @override
  _AddInternalMeeting createState() => new _AddInternalMeeting();
}

class _AddInternalMeeting extends State<QuestionUser> with SingleTickerProviderStateMixin  {

  File _image;
  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseReference _userRef = FirebaseDatabase.instance.reference().child("Users").child("Mostafa").child("MyQuestions");



  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  final MyQuestionControler = TextEditingController();



  UploadtoFirebase() async {

    String newkey =_userRef.push().key;

   if(_image == null)
     {
       _userRef.child(newkey).set(<String, String>{

         "MyQuestion": MyQuestionControler.text,
         "image":  "Image",
         "uid":  newkey,

       }).then((_) {
         print('Transaction  committed.');
       });
     }
     else
       {
         String fileName = _image.path.toString();
         StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
         StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
         StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
         String url = (await firebaseStorageRef.getDownloadURL()).toString();

         _userRef.child(newkey).set(<String, String>{

           "MyQuestion": MyQuestionControler.text,
           "image":  "Image",
           "uid":  newkey,

         }).then((_) {
           print('Transaction  committed.');
         });

         _userRef.child(newkey).update(<String, String>{
           "image":  url,
         }).then((_) {
           print('Transaction  committed.');
         });


         setState(() {
           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Picture Uploaded')));
         });
       }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:AppBar(
        title: Padding(padding: new EdgeInsets.only(left: 50),
          child: Image.asset('images/iservebar.png', fit: BoxFit.cover),),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),

      ) ,
      body: _buildMainConent(),
    );
  }

  _buildMainConent() {

    final CatgControler = TextEditingController();

    showAlertDialog(BuildContext context) {

      // set up the list options
      Widget optionOne = SimpleDialogOption(
        child: const Text('Fitness'),
        onPressed: () {
          CatgControler.text = 'Fitness';
        },
      );
      Widget optionTwo = SimpleDialogOption(
        child: const Text('Vet'),
        onPressed: () {
          CatgControler.text = 'Vet';
        },
      );
      Widget optionThree = SimpleDialogOption(
        child: const Text('Lawyer'),
        onPressed: () {
          CatgControler.text = 'Lawyer';
        },
      );
      Widget optionFour = SimpleDialogOption(
        child: const Text('Doctor'),
        onPressed: () {
          CatgControler.text = 'Doctor';
        },
      );

      // set up the SimpleDialog
      SimpleDialog dialog = SimpleDialog(
        title: const Text('Choose Category'),
        children: <Widget>[
          optionOne,
          optionTwo,
          optionThree,
          optionFour,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        },
      );
    }

    return  Container(
      child:
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SafeArea(
          child:  ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 20,left: 20) ,
                      child: RaisedButton(
                        color: const Color(0xff007944),
                        child: Text('Choose Category'),
                        shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          showAlertDialog(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 20,left: 20) ,
                      child:  TextField(
                        style: TextStyle(color: const Color(0xff007944)),
                        controller: CatgControler,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Please choose Category'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:new Text('My Question',
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:new TextField(
                        controller: MyQuestionControler,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What is IServe ?'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:new Text('Image',
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:Center(
                        child: _image == null
                            ? new Text('No image selected.')
                            : new Image.file(_image),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child:RaisedButton(
                        splashColor: Colors.pinkAccent,
                        color: Colors.black,
                        child: new Text(
                          "Add Photo",
                          style: new TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: () {getImage();},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50,bottom: 40),
                      child:RaisedButton(
                        splashColor: Colors.white,
                        color: Colors.black,
                        child: new Text(
                          "Submit",
                          style: new TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: () {showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child:Text("Are you sure") ,),
                                        SizedBox(
                                          width: 320.0,
                                          child: Column(
                                            children: [
                                              RaisedButton(
                                                onPressed: () {
                                                  if(MyQuestionControler.text == "")
                                                    {
                                                      Fluttertoast.showToast(
                                                          msg: "Please enter QUESTION first",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 2);
                                                    }
                                                  else
                                                    {
                                                    UploadtoFirebase();
                                                  }
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                color: const Color(0xFF1BC0C5),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                color: const Color(0xFF1BC0C5),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });},
                      ),
                    ),

                  ]),
            ],
          ),),)
      ,);
  }




}


// replace this function with the examples above
