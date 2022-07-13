import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:knm/callapi/api_signup_signin.dart';
import 'package:knm/signin_signup/detail_user.dart';
import 'package:knm/signin_signup/user_account/controller.dart';
import 'package:get/get.dart';
import 'package:knm/signin_signup/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  ////////////////////////////////////////////////////////////////////////////
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        print(selectedDate);
        print(_dateController.text);
      });
  }
  String confirmgender = values[0];
  int index = 0;
  static List<String> values = ['ຊາຍ', 'ຍິງ', 'ອື່ນໆ'];
  FocusNode _node = FocusNode();
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
    profileUser();
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
      Navigator.pop(context);
      controller.onInit();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => User_detail()));
    }
  }
    Widget dialog3() => const CupertinoAlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text('ກະລຸນາລໍຖ້າ')),
        ),
      );

  _updateDataUser() async {
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? id = preferences.getString('id');
    print('null!!!!');
    var data = {
      'name': name.text,
      'surname': surname.text,
      'email': email.text,
      'gender': confirmgender,
      'birth': _dateController.text,
      
    };
    var res = await CallApi().postDataProfile_user(data, id.toString(), token);
    var body = json.decode(res.body);
    print(body);
    print('statusCode====>' + res.statusCode.toString());
    if (res.statusCode == 200) {
      Navigator.pop(context);
      controller.onInit();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => User_detail()));
    }
  }

  UploadTask? uploadTask;
  late String urlImag1;

  Future profileUser() async {
    showDialog(context: context, builder: (_) => dialog3());
    final path = 'profile/Knm-${_image!.name}';
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
    profileUser();
    //Get.to(Edit_account());
  }

  final Controller controller = Get.find<Controller>();
  bool statename = false;
  bool statesurname = false;
  bool stateemail2 = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ',
          style: TextStyle(fontFamily: 'nsl_bold'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.10),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => photo(context));
                        },
                        child: Stack(
                          children: [
                            Obx((){
                              if(controller.isLoading.value)
                              // ignore: curly_braces_in_flow_control_structures
                              return Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(55), color: Colors.white),
                                child: Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                ),);
                              else{
                                return Container(
                                width: 110,
                                height: 110,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Image.network(
                                      controller.photoList[0].profile.toString(),
                                      fit: BoxFit.cover,
                                    )));
                              }
                            }),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                            width: 2, color: Colors.blue),
                                        color: Colors.white),
                                    child: Icon(Icons.camera_enhance,
                                        color: Colors.blue, size: 22)))
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          children: [
                            text('ຊື່'),
                            SizedBox(height: 5),
                            inputname(width),
                            SizedBox(height: 5),
                            text('ນາມສະກຸນ'),
                            SizedBox(height: 5),
                            inputsurname(width),
                            SizedBox(height: 5),
                            text('ອີເມວ'),
                            SizedBox(height: 5),
                            inputemail(width),
                            SizedBox(height: 5),
                            text('ເພດ'),
                            SizedBox(height: 5),
                            inputgender(width, 'ເພດ'),
                            SizedBox(height: 5),
                            SizedBox(height: 5),
                            text('ວັນເດືອນປີເກີດ'),
                            SizedBox(height: 5),
                            inputbirthday(width),
                            SizedBox(height: 5),
                            SizedBox(height: 10),
                            Container(
                              width: width,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(context: context, builder: (_) => dialog3());
                                    _updateDataUser();
                                  },
                                  child: Text(
                                    'ບັນທຶກ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

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

  Row text(String text) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                fontFamily: 'nsl_regular',
                color: Colors.grey.shade600,
                fontSize: 16)),
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

////////////////////////////////////////////
  Container inputname(double screen) {
    return Container(
      width: screen * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(width: 1.5, color: Colors.lightBlue),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: name,
          decoration: InputDecoration(
            hintText: 'ຊື່',
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(width: 1.5, color: Colors.lightBlue),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: surname,
          decoration: InputDecoration(
            hintText: 'ນາມສະກຸນ',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputemail(double screen) {
    return Container(
      width: screen * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(width: 1.5, color: Colors.lightBlue),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: email,
          decoration: InputDecoration(
            hintText: 'ອີເມວ',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputgender(double screen, String text) {
    return Container(
        width: screen,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.lightBlue, width: 1.5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: TextFormField(
            onTap: () {
              _node.unfocus();
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                        actions: [
                          Container(
                            height: 150,
                            child: CupertinoPicker(
                              itemExtent: 50,
                              diameterRatio: 0.7,
                              looping: false,
                              onSelectedItemChanged: (index) {
                                setState(() => this.index = index);
                                print(values[index]);
                                setState(() {
                                  gender.text = values[index];
                                });
                              },
                              children: Utils.modelBuilder<String>(
                                values,
                                (index, value) {
                                  Colors.black;
                                  return Center(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  confirmgender = values[index];
                                  text = confirmgender;
                                });
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.green),
                              )),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancle',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ));
            },
            focusNode: _node,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: confirmgender == null ? text : confirmgender,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              fillColor: Colors.white,
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ));
  }

  Container inputbirthday(double screen) {
    return Container(
        width: screen,
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.lightBlue, width: 1.5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: TextFormField(
            onTap: () {
              _node.unfocus();
              _selectDate(context);
            },
            focusNode: _node,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: _dateController.text,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              fillColor: Colors.white,
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ));
  }
}
