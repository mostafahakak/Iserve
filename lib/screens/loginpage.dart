import 'package:elsalonapp/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 100),
                    child: Image.asset('images/iservebar.png', fit: BoxFit.cover)),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20,color: const Color(0xff007944)),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(hintText: 'Enter phone number'),
                                onChanged: (val) {
                                  setState(() {
                                    this.phoneNo = val;
                                  });
                                },
                              )),
                          codeSent ? Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(hintText: 'Enter OTP'),
                                onChanged: (val) {
                                  setState(() {
                                    this.smsCode = val;
                                  });
                                },
                              )) : Container(),
                        ],
                      )),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.only(top: 10,),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: const Color(0xff007944),
                      child: Text('Login'),
                      onPressed: () {
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);

                      },
                    )),
              ],
            )));

  }
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

}
