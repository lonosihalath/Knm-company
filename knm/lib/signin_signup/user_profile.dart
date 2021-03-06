// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knm/callapi/api_signup_signin.dart';
import 'package:knm/condition/condition_screen.dart';
import 'package:knm/screen/callcenter/callcenter.dart';
import 'package:knm/screen/home/homepage.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/signin_signup/detail_user.dart';
import 'package:knm/signin_signup/user_account/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({Key? key}) : super(key: key);

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  @override
  void initState() {
    findUser();
    super.initState();
    loadimage();
  }

  late var NameUser = '';
  late var Useremail = '';
  late var Userid = '';
  late var Usertoken = '';
  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Usertoken = preferences.getString('token')!;
      Userid = preferences.getString('id')!;
    });
  }

  void loadimage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      imagepath = saveimage.getString('imagepath');
    });
  }

  XFile? _image;
  late String urlImag;
  late var imagepath;
  // List<XFile>? _image1;
  ImagePicker? picker = ImagePicker();
  Future getimage() async {
    final XFile? pickedFile = await picker!.pickImage(
      source: ImageSource.camera,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    setState(() {
      _image = pickedFile!;
      imagepath = _image!.path;
    });
    saveImage(_image!.path);
    profileUser();

    //Get.to(Edit_account());
  }

  _updateDataImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? id = preferences.getString('id');
    print('null!!!!');
    var data = {
      'profile': urlImag1,
    };
    var res = await CallApi().postDataProfile_user(data, id.toString(), token);
    var body = json.decode(res.body);
    print(body);
    print('statusCode====>' + res.statusCode.toString());
    if (res.statusCode == 200) {
      controller.onInit();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Edit_account()));
    }
  }

  UploadTask? uploadTask;
  late String urlImag1;

  Future profileUser() async {
    final path = 'profile/BundoStore-$Userid${_image!.name}';
    final file = File(_image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlImage = await snapshot.ref.getDownloadURL();
    setState(() {
      urlImag1 = urlImage;
    });
    _updateDataImage();
    print('Linkkkkkkkkkkk: ' + urlImage);
  }

  Future getimage1() async {
    final XFile? pickedFile = await picker!.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    setState(() {
      _image = pickedFile!;
      imagepath = _image!.path;
    });
    saveImage(_image!.path);
    profileUser();
    //Get.to(Edit_account());
  }

  void saveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString('imagepath', path);
  }

  OrderShowController orderShowController = Get.put(OrderShowController());

  Future<void> _Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    showDialog(context: context, builder: (context) => dialog3());
    Future.delayed(Duration(seconds: 2),(){
      controller.photoList.clear();
      orderShowController.statetList.clear();
       Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage_Screen()));
    });

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage_Screen()),
    //     (route) => false);
  }

  final Controller controller = Get.find<Controller>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
        child: Center(
            child: Column(
          children: [
            SizedBox(height: height * 0.10),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                    context: context, builder: (context) => photo(context));
              },
              child: Obx(() {
                    if (controller.isLoading.value)
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    else {
                      return Container(
                          width: 110,
                          height: 110,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.network(controller.photoList.isEmpty ? '' :
                                controller.photoList[0].profile.toString(),
                                fit: BoxFit.cover,
                              )));
                    }
                  }),
            ),
            SizedBox(height: 10),
            Text(controller.photoList.isEmpty ? '?????????' :controller.photoList[0].name.toString(),
                style: TextStyle(
                    color: Colors.white, fontFamily: 'nsl_bold', fontSize: 18)),
            Text(controller.photoList.isEmpty ? '???????????????' :controller.photoList[0].email.toString(),
                style: TextStyle(
                    color: Colors.white, fontFamily: 'nsl_bold', fontSize: 18)),
            SizedBox(height: 40),
            Container(
              width: width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Icon(Icons.person_sharp, color: Colors.white, size: 35),
                    title: Text(
                      '?????????????????????????????????',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => User_detail()));
                    },
                  ),
                  ListTile(
                    leading: Container(
                        width: 30,
                        height: 35,
                        child: Image.asset(
                          'images/callcenter.png',
                          color: Colors.white,
                        )),
                    title: Text(
                      '???????????????????????????????????????',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                    Get.to(Callcenter_Screen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list_alt_rounded,
                        color: Colors.white, size: 35),
                    title: Text(
                      '???????????????????????? ????????? ????????????????????????',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      Get.to(ConditionScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white, size: 35),
                    title: Text(
                      '?????????????????????????????????',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      showDialog(context: context, builder: (_) => dialog());
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget dialog3() => CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text('?????????????????????????????????')),
        ),
      );

  Widget dialog() => CupertinoAlertDialog(
        title: Text('Log out'),
        content: Text('Are you sure to Log out ?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () async {
              await _googleSignIn.signOut();
              Navigator.pop(context);
              _Logout();
            },
          ),
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

  CupertinoActionSheet photo(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('?????????????????????????????????')),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              getimage();
            },
            child: Text('?????????????????????????????????')),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              getimage1();
            },
            child: Text('?????????????????????????????????'))
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
