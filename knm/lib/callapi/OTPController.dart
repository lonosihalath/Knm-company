import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:knm/screen/home/homepage.dart';

class OTP_Screen extends StatefulWidget {
  final String phone;
  final String codeDigits;
  OTP_Screen({required this.phone, required this.codeDigits});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,
      ));

  String? varificationCode;
  String? token;
  String code1 = "";

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    verifyPhneNumber();
  }

  verifyPhneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credentail) async {
        siginPhone(credentail);
        await FirebaseAuth.instance
            .signInWithCredential(credentail)
            .then((value) {
          if (value.user != null) {
            print('555555555==========>' + '${value.user!.getIdToken()}');
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => HomePage_Screen()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String vID, int? resentToken) {
        setState(() {
          varificationCode = vID;
          token = resentToken.toString();
          print('Token=====> ' + token.toString());
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          varificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<void> siginPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      var firebaseAccessToken = await authResult.user!.getIdToken();
      print('firebaseAccessToken=====>' + firebaseAccessToken.toString());
    } catch (e) {
      print(e);
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      var tokenaccess = await authCredential.user!.getIdToken();
      var tokenaccess1 = await authCredential.user!.getIdTokenResult();
      print('User======>'+authCredential.user!.toString());
      print('tokenid=====>' + tokenaccess.toString());
      print('tokenacid555=====>' + tokenaccess1.toString());

      if (authCredential.user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage_Screen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
      appBar: AppBar(
        title: Text('OTP'),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: GestureDetector(
              onTap: () {
                verifyPhneNumber();
              },
              child: Text(
                'Verifying : ${widget.codeDigits}-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(40.0),
          child: OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (pin) async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: varificationCode!, smsCode: pin);

              signInWithPhoneAuthCredential(phoneAuthCredential);

              // try {
              //   await FirebaseAuth.instance
              //       .signInWithCredential(PhoneAuthProvider.credential(
              //           verificationId: varificationCode!, smsCode: pin))
              //       .then((value) {
              //     if (value.user != null) {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (c) => HomePage_Screen()));
              //     }
              //   });
              // } catch (e) {
              //   FocusScope.of(context).unfocus();
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('Invalid OTP'),
              //       duration: Duration(seconds: 3),
              //     ),
              //   );
              // }
            }, // end onSubmit
          ),
        )
      ]),
    );
  }
}
