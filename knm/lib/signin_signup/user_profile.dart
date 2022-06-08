// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knm/screen/home/homepage.dart';
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
    //_updateDataImage();

    //Get.to(Edit_account());
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
    //_updateDataImage();
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

  Future<Null> _Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    setState(() {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage_Screen()));
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage_Screen()),
    //     (route) => false);
  }

  final Controller controller = Get.find<Controller>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    print(Usertoken);
    print(Userid);
    print(controller.photoList.length);
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
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(controller.photoList[0].profile.toString(),fit: BoxFit.cover,))
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(width: 2, color: Colors.blue),
                              color: Colors.white),
                          child: Icon(Icons.camera_enhance,
                              color: Colors.blue, size: 22)))
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(controller.photoList[0].name.toString(),
                style: TextStyle(
                    color: Colors.white, fontFamily: 'nsl_bold', fontSize: 18)),
            Text(controller.photoList[0].email.toString(),
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
                      'ຂໍ້ມູນບັນຊີ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      //Get.to(Myaccount());
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
                      'ຕິດຕໍ່ພວກເຮົາ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      //Get.to(Myaccount());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list_alt_rounded,
                        color: Colors.white, size: 35),
                    title: Text(
                      'ຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nsl_bold',
                          fontSize: 20),
                    ),
                    onTap: () {
                      //Get.to(Myaccount());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white, size: 35),
                    title: Text(
                      'ອອກຈາກລະບົບ',
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

  Widget dialog() => CupertinoAlertDialog(
        title: Text('Log out'),
        content: Text('Are you sure to Log out ?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () async {
             await _googleSignIn.signOut();
              Navigator.pop(context);
              controller.onInit();
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
            child: Text('ເບິ່ງຮູບພາບ')),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              getimage();
            },
            child: Text('ກ້ອງຖ່າຍຮູບ')),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              getimage1();
            },
            child: Text('ເລືອກຮູບພາບ'))
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
