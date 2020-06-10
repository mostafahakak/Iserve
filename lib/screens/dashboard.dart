import 'package:elsalonapp/screens/AskQuestion.dart';
import 'package:elsalonapp/screens/MyQuestions.dart';
import 'package:elsalonapp/screens/profile.dart';
import 'package:elsalonapp/services/authservice.dart';
import 'package:flutter/material.dart';

import '../Test.dart';
import 'Home.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {

  ScrollController _scrollViewController;
  int _selectedTab = 0;
  final _pageOptions = [
    Test(),
    MyQuestions(),
    MyHomePage(),
    AskQuestion()
  ];

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title: Padding(padding: new EdgeInsets.only(left: 50),
      child: Image.asset('images/iservebar.png', fit: BoxFit.cover),),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),

      ) ,
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Mostafa Ashraf"),
              decoration: BoxDecoration(
                color: const Color(0xff007944),
              ),
            ),
            ListTile(
              leading: new IconButton(
                icon: new Icon(Icons.home, color: Colors.black),
                onPressed: () => null,
              ),
              title: Text('Home'),
              onTap: null,
            ),
            ListTile(
              leading: new IconButton(
                icon: new Icon(Icons.book, color: Colors.black),
                onPressed: () => null,
              ),
              title: Text('Our story'),
              onTap: null,
            ),
            ListTile(
              leading: new IconButton(
                icon: new Icon(Icons.contacts, color: Colors.black),
                onPressed: () => null,
              ),
              title: Text('Contact us'),
              onTap: null,
            ),
            ListTile(
              leading: new IconButton(
                icon: new Icon(Icons.exit_to_app, color: Colors.black),
                onPressed:null,
              ),
              title: Text('Log out'),
              onTap: () {AuthService().signOut();
              },
            ),
          ],
        ),
      ),
      body: _pageOptions[_selectedTab] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (int index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: const Color(0xff007944)),
            title: Text('Home',style: TextStyle(
              color: Colors.black,
            ),),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.black,
            icon: Icon(Icons.message,color: const Color(0xff007944)),
            title: Text('My Questions',style: TextStyle(
              color: Colors.black,
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face,color: const Color(0xff007944)),
            title: Text('Profile',style: TextStyle(
              color: Colors.black,
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer,color: const Color(0xff007944)),
            title: Text('Ask',style: TextStyle(
              color: Colors.black,
            )),
          ),

        ],
      ),
    );
  }
}