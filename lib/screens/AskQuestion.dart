import 'package:flutter/material.dart';


class AskQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: MyLayout()),
    );
  }
}

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: Text('Show alert'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

// replace this function with the examples above
showAlertDialog(BuildContext context) {

  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('Fitness'),
    onPressed: () {
      print('Fitness');
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('Vet'),
    onPressed: () {
      print('Vet');
    },
  );
  Widget optionThree = SimpleDialogOption(
    child: const Text('Lawyer'),
    onPressed: () {
      print('Lawyer');
    },
  );
  Widget optionFour = SimpleDialogOption(
    child: const Text('Doctor'),
    onPressed: () {
      print('Doctor');
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