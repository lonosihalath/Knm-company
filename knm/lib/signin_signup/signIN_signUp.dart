// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/callapi/api_signup_signin.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/condition/condition_screen.dart';
import 'package:knm/screen/home/homepage.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/signin_signup/user_account/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Signin_SignUP extends StatefulWidget {
  const Signin_SignUP({Key? key}) : super(key: key);

  @override
  State<Signin_SignUP> createState() => _Signin_SignUPState();
}

class _Signin_SignUPState extends State<Signin_SignUP> {
  bool status = true;
  bool stutusRedEye = true;
  bool stateemail1 = false;
  bool statepassword1 = false;
  bool statename = false;
  bool statesurname = false;
  bool stateemail2 = false;
  bool statepassword2 = false;
  bool statephone = false;

  bool isChecked = false;

  TextEditingController email1 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController cfpassword = TextEditingController();
  final Controller controller = Get.find<Controller>();
  OrderShowController orderShowController = Get.put(OrderShowController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  BranchController branchController = Get.put(BranchController());

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _register() async {
    var data = {
      'name': name.text,
      'surname': surname.text,
      'email': email2.text,
      'phone': phone.text,
      'birth': '?????????????????????',
      'gender': '?????????????????????',
      'password': password2.text,
      'password_confirmation': password2.text,
    };
    var res = await CallApi().postData(
      data,
      'register',
    );
    print(data);
    print('Response status: ${res.statusCode}');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 422 ||
        body.toString() ==
            '{message: The given data was invalid., errors: {password: [The password confirmation does not match.]}}') {
      showDialog(context: context, builder: (context) => dialog2());
      //cfPassword('????????????????????????????????????', '??????????????? ????????? ?????????????????????????????????????????????');
    } else {
      if (body['success']) {
        setState(() {
          status = true;
        });
      }
    }
  }

  _login() async {
    print('null!!!!');
    var data = {'email': email1.text, 'password': password1.text};
    var res = await CallApi().postDatalogin(
      data,
      'login',
    );
    var body = json.decode(res.body);
    print(body);
    if (body.toString() == '{massage: Email or Password wrong!!}') {
      showDialog(context: context, builder: (context) => dialog());
    }
    if (res.statusCode == 201) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('id', json.encode(body['user']['id']));
      orderShowController.onInit();
      controller.onInit();
      Timer(Duration(seconds: 2), () {
              controller.onInit();
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage_Screen()));
            });
      localStorage.setString('phone', body['user']['phone']);
    } else {
      print('No!!!!!!!!!!!!!!!!!!');
    }
  }

  Widget dialog3() => CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text('?????????????????????????????????')),
        ),
      );
  Widget dialog() => CupertinoAlertDialog(
        title: Text('Worning !!!'),
        content: Text('Email or Password wrong!!'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
  Widget dialog2() => CupertinoAlertDialog(
        title: Column(
          children: [
            Icon(Icons.warning,
                color: Color.fromARGB(255, 255, 21, 0), size: 35),
            Text('????????????????????????????????????'),
          ],
        ),
        content: Text('??????????????? ????????? ?????????????????????????????????????????????'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
  Widget dialog4() => CupertinoAlertDialog(
        title: Column(
          children: [
            Icon(Icons.warning,
                color: Color.fromARGB(255, 255, 21, 0), size: 35),
            Text(''),
          ],
        ),
        content: Text('???????????????????????????????????????????????????????????? ????????? ????????????????????????'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

  String dialDodeDigis = "+856";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              )),
          title: Text(
            '???????????????????????????????????????????????????',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              status = true;
                            });
                          },
                          child: Text('???????????????????????????????????????',
                              style: TextStyle(
                                  fontFamily: 'nsl_bold',
                                  color: status == true
                                      ? Colors.white
                                      : Colors.white60,
                                  fontSize: 18))),
                      Container(
                        width: 110,
                        height: 110,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(
                              'images/logo.jpeg',
                              fit: BoxFit.cover,
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              status = false;
                            });
                          },
                          child: Text('????????????????????????',
                              style: TextStyle(
                                  fontFamily: 'nsl_bold',
                                  color: status == false
                                      ? Colors.white
                                      : Colors.white60,
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 20),
                  status == true
                      ? Column(
                          children: [
                            text('???????????????'),
                            SizedBox(height: 5),
                            inputemail1(width),
                            SizedBox(height: 5),
                            stateemail1 == true
                                ? varidator('???????????????????????????')
                                : SizedBox(
                                    height: 5,
                                  ),

                            text('???????????????????????????'),
                            SizedBox(height: 5),
                            inputPassword(width),
                            SizedBox(height: 5),
                            statepassword1 == true
                                ? varidator('???????????????????????????????????????')
                                : varidator(''),

                            forgetPassword(),
                            buttonLogingoogle(width, height),
                            buttonLogin(width),
                            // login(),
                          ],
                        )
                      : Column(
                          children: [
                            text('?????????'),
                            SizedBox(height: 5),
                            inputname(width),
                            SizedBox(height: 5),
                            statename == true
                                ? varidator('?????????????????????')
                                : SizedBox(
                                    height: 5,
                                  ),
                            text('????????????????????????'),
                            SizedBox(height: 5),
                            inputsurname(width),
                            SizedBox(height: 5),
                            statesurname == true
                                ? varidator('????????????????????????????????????')
                                : SizedBox(
                                    height: 5,
                                  ),
                            text('?????????????????????'),
                            SizedBox(height: 5),
                            inputphone(width),
                            SizedBox(height: 5),
                            statesurname == true
                                ? varidator('???????????????????????????')
                                : SizedBox(
                                    height: 5,
                                  ),
                            text('???????????????'),
                            SizedBox(height: 5),
                            inputemail2(width),
                            SizedBox(height: 5),
                            stateemail2 == true
                                ? varidator('???????????????????????????')
                                : SizedBox(
                                    height: 5,
                                  ),
                            text('???????????????????????????'),
                            SizedBox(height: 5),
                            inputPassword2(width),
                            SizedBox(height: 5),
                            statepassword2 == true
                                ? varidator('???????????????????????????????????????')
                                : varidator(''),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.blue,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      print(isChecked);
                                    });
                                  },
                                ),
                                text('??????????????????????????????????????? ????????? ????????????????????????'),
                                SizedBox(width: 15),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 2))),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ConditionScreen()));
                                    },
                                    child: Text(
                                      '???????????????????????????',
                                      style: TextStyle(
                                          fontFamily: 'nsl_regular',
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            buttonregister(width)
                          ],
                        )
                ],
              ),
            ),
          ),
        ));
  }

  Row text(String text) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                fontFamily: 'nsl_regular', color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Padding varidator(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 2, top: 2),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 12, color: Colors.red)),
        ],
      ),
    );
  }

/////////////////// SingIN//////////////////////
  Container inputemail1(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: email1,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: 'email',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputPassword(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          style: TextStyle(fontSize: 16),
          keyboardType: TextInputType.visiblePassword,
          controller: password1,
          obscureText: stutusRedEye,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: stutusRedEye
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  stutusRedEye = !stutusRedEye;
                });
              },
            ),
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Container buttonLogingoogle(double screen, height1) {
    return Container(
      width: screen * 0.90,
      margin: EdgeInsets.only(top: 15),
      height: 40,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          String accessToken = '';
          String provider1 = 'google';
          print('lono');
          try {
            var email = '';
            var name = '';
            var image = '';
            var accessToken = '';
            var idToken = '';
            var reslut = await _googleSignIn.signIn();
            var token = await reslut!.authentication;
            setState(() {
              email = reslut.email;
              name = reslut.displayName.toString();
              image = reslut.photoUrl.toString();
              accessToken = token.accessToken.toString();
              idToken = token.idToken.toString();
            });
            print('idToken ==>>>' + idToken.length.toString());
            showDialog(context: context, builder: (context) => dialog3());
            String _url =
                'http://10.0.2.2:8000/api/socialite/login?provider_name=$provider1&access_token=$accessToken';
            var respone = await http.get(Uri.parse(_url), headers: {
              'Accept': 'application/json',
            });
            var res = json.decode(respone.body);

            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setString('token', res['token']);
            localStorage.setString('id', json.encode(res['user']['id']));
            controller.onInit();
            orderShowController.onInit();
            categoriesController.onInit();
            branchController.onInit();
            controller.onInit();
            Timer(Duration(seconds: 2), () {
              controller.onInit();
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage_Screen()));
            });

            print('respone : $res');
          } catch (error) {
            print(error);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 25, child: Image.asset('images/google.png')),
            SizedBox(width: 15),
            Text(
              'Login with Google',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: 'branding'),
            ),
          ],
        ),
      ),
    );
  }

  Container buttonLogin(double screen) {
    return Container(
      width: screen * 0.90,
      margin: EdgeInsets.only(top: 15),
      height: 45,
      child: RaisedButton(
        color: Color.fromARGB(255, 10, 84, 188),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          if (email1.text.isEmpty) {
            setState(() {
              stateemail1 = true;
            });
          } else {
            setState(() {
              stateemail1 = false;
            });
          }
          if (password1.text.isEmpty) {
            setState(() {
              statepassword1 = true;
            });
          } else {
            setState(() {
              statepassword1 = false;
            });
          }
          if (email1.text.isNotEmpty && password1.text.isNotEmpty) {
            showDialog(context: context, builder: (context) => dialog3());
            _login();
          }
        },
        child: Text(
          '???????????????????????????????????????',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontFamily: 'nsl_regular'),
        ),
      ),
    );
  }

  TextButton forgetPassword() {
    return TextButton(
        onPressed: () {},
        child: Text(
          '???????????????????????????????????? ?',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontFamily: 'nsl_regular'),
        ));
  }

  ///////////////////////////////Register//////////////////////
  ///
  Container inputname(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: name,
          decoration: InputDecoration(
            hintText: '?????????',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputsurname(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: surname,
          decoration: InputDecoration(
            hintText: '????????????????????????',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputemail2(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: email2,
          decoration: InputDecoration(
            hintText: '???????????????',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
  Container inputphone(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: phone,
          decoration: InputDecoration(
            hintText: '?????????????????????',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputPassword2(double screen) {
    return Container(
      width: screen * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          style: TextStyle(fontSize: 16),
          keyboardType: TextInputType.visiblePassword,
          controller: password2,
          obscureText: stutusRedEye,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: stutusRedEye
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  stutusRedEye = !stutusRedEye;
                });
              },
            ),
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Container buttonregister(double screen) {
    return Container(
      width: screen * 0.90,
      margin: EdgeInsets.only(top: 15),
      height: 45,
      child: RaisedButton(
        color: Color.fromARGB(255, 10, 84, 188),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          if (name.text.isEmpty) {
            setState(() {
              statename = true;
            });
          } else {
            setState(() {
              statename = false;
            });
          }
          if (surname.text.isEmpty) {
            setState(() {
              statesurname = true;
            });
          } else {
            setState(() {
              statesurname = false;
            });
          }
          if (email2.text.isEmpty) {
            setState(() {
              stateemail2 = true;
            });
          } else {
            setState(() {
              stateemail2 = false;
            });
          }
          if (password2.text.isEmpty) {
            setState(() {
              statepassword2 = true;
            });
          } else {
            setState(() {
              statepassword2 = false;
            });
          }
          if (phone.text.isEmpty) {
            setState(() {
              statephone = true;
            });
          } else {
            setState(() {
              statephone = false;
            });
          }
          if (name.text.length.toInt() == 0 &&
              surname.text.length.toInt() == 0 &&
              phone.text.length.toInt() == 0&&
              email2.text.length.toInt() == 0 &&
              password2.text.length.toInt() == 0){
            print(0);
          } else {
            if(isChecked == true){
              _register();
            }else{
              showDialog(context: context, builder: (context) => dialog4());
            }
            
            print('1');
          }
        },
        child: Text(
          '????????????????????????',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontFamily: 'nsl_regular'),
        ),
      ),
    );
  }
}
