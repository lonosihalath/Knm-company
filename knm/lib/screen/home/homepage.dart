import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:knm/brand/brand_controller.dart';
import 'package:knm/categories/comtroller.dart';
import 'package:knm/screen/order/create_order.dart';
import 'package:knm/screen/home/datasakha.dart';
import 'package:knm/screen/kitlailakha/kidlailakha.dart';
import 'package:knm/screen/order/detail_order.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/screen/order/show_order_model.dart';
import 'package:knm/screen/tackking/order.dart';
import 'package:knm/screen/tackking/order_Tacking.dart';
import 'package:knm/signin_signup/signIN_signUp.dart';
import 'package:knm/signin_signup/user_account/controller.dart';
import 'package:knm/signin_signup/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage_Screen extends StatefulWidget {
  const HomePage_Screen({Key? key}) : super(key: key);

  @override
  State<HomePage_Screen> createState() => _HomePage_ScreenState();
}

class _HomePage_ScreenState extends State<HomePage_Screen> {
  ScrollController scrollController = ScrollController();
  bool statusTab1 = true;
  bool statusTab2 = false;
  bool statusTab3 = false;
  bool statussubTab1 = true;
  bool statussubTab2 = false;
  late List<String> textmain = ['ໜ້າຫຼັກ', 'ພັດສະດຸ', 'ຊ່ວຍເຫຼືອ'];
  late List<String> textmain1 = ['ຂ້ອຍຈັດສົ່ງ', 'ສົ່ງໃຫ້ຂ້ອຍ'];
  late List<String> textmain2 = ['ກຳລັງຈັດສົ່ງ', 'ສົ່ງສຳເລັດ'];
  late List<String> textmain3 = ['ກຳລັງຈັດສົ່ງ', 'ສົ່ງສຳເລັດ'];
  late String texttap = '';
  final List<String> imgList = ['images/lazada3.jpg', 'images/lazada4.jpg'];
  late int selected = 0;
  late int selected1 = 0;
  late int selected2 = 0;
  late int selected3 = 0;

  @override
  void initState() {
    super.initState();
    findUser();
    controller.onInit();
    orderShowController.onInit();
  }

  var Usertoken;
  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Usertoken = preferences.getString('token')!;
    });
  }

  late var imagepath;
  void loadimage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      imagepath = saveimage.getString('imagepath');
    });
  }

  final Controller controller = Get.find<Controller>();
  BranchController branchController = Get.put(BranchController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  OrderShowController orderShowController = Get.put(OrderShowController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color.fromARGB(255, 22, 141, 239),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: width,
              height: 65,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFEBA00), width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      textmain.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            texttap = textmain[index];
                          });
                          if (texttap == 'ໜ້າຫຼັກ') {
                            setState(() {
                              statusTab1 = true;
                            });
                          } else {
                            setState(() {
                              statusTab1 = false;
                            });
                          }
                          if (texttap == 'ພັດສະດຸ') {
                            setState(() {
                              statusTab2 = true;
                              orderShowController.onInit();
                            });
                          } else {
                            setState(() {
                              statusTab2 = false;
                            });
                          }
                          if (texttap == 'ຊ່ວຍເຫຼືອ') {
                            setState(() {
                              statusTab3 = true;
                            });
                          } else {
                            setState(() {
                              statusTab3 = false;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? Color(0xFF1380F7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            textmain[index],
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontFamily: 'nsl_bold',
                                color: selected == index
                                    ? Colors.white
                                    : Color(0xFF1380F7),
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )),
              ),
            )),
      ),
      //extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: statusTab1 == true
                ? Column(
                    children: [
                      // SizedBox(height: height * 0.05),
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 50),
                            viewportFraction: 1.0,
                            enlargeCenterPage: true,
                            //enableInfiniteScroll: false,

                            autoPlay: true
                            // autoPlay: false,
                            ),
                        items: imgList
                            .map((item) => Container(
                                margin: EdgeInsets.all(10),
                                height: 350,
                                width: width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                  ),
                                )))
                            .toList(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * 0.75,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Tracking ID',
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              controller.photoList.isEmpty
                                                  ? Signin_SignUP()
                                                  : User_Profile()));
                                },
                                child: Container(
                                    width: 60,
                                    child: Obx(() {
                                      if (controller.isLoading.value)
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white),
                                        );
                                      else {
                                        return controller.photoList.length
                                                    .toInt() !=
                                                0
                                            ? Container(
                                                width: 60,
                                                height: 60,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                      controller
                                                          .photoList[0].profile
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                    )))
                                            : Image.asset('images/profile.png');
                                      }
                                    })))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Wrap(
                              runSpacing: 20,
                              spacing: 20,
                              alignment: WrapAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                    controller.photoList.isEmpty ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Signin_SignUP())) :  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateOrder()));
                                    },
                                    child: item_main(
                                        'images/kong1.png',
                                        'ຝາກເຄື່ອງເອງ',
                                        Container(
                                              width: 80,
                                              height: 80,
                                              child: Image.asset(
                                                  'images/kong1.png',
                                                  fit: BoxFit.contain)),)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = 1;
                                      statusTab2 = true;
                                      statusTab1 = false;
                                      statusTab3 = false;
                                    });
                                  },
                                  child: item_main(
                                      'images/kong2.png', 'ພັດສະດຸຂອງຂ້ອຍ',Container(
                                              width: 80,
                                              height: 80,
                                              child: Image.asset(
                                                  'images/kong2.png',
                                                  fit: BoxFit.contain)),),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Kidlailakha_screen()));
                                  },
                                  child: item_main(
                                      'images/kong5.png', 'ຄິດໄລ່ຄ່າຂົນສົ່ງ',Container(
                                        width: 100,
                                              child: Image.asset(
                                                  'images/kong5.png',
                                                  fit: BoxFit.contain)),),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SskhaData_Screen()));
                                    },
                                    child: item_main(
                                        'images/kong3.png', 'ຂໍ້ມູນສາຂາ',Container(
                                              width: 90,
                                              height: 90,
                                              child: Image.asset(
                                                  'images/kong3.png',
                                                  fit: BoxFit.contain)),)),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  OrderTotacking()));
                                    },
                                    child: item_main(
                                        'images/kong4.png', 'Prackink',Container(
                                              width: 80,
                                              height: 90,
                                              child: Image.asset(
                                                  'images/kong1.png',
                                                  fit: BoxFit.contain)),)),
                                // GestureDetector(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (_) => Phuhub_Screen()));
                                //     },
                                //     child: item_main(
                                //         'images/preson.png', 'ຂໍ້ມູນຜູ້ຮັບ')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : statusTab2 == true
                    ? Container(
                        child: Column(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   width: width * 0.95,
                          //   height: 50,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       color: Colors.white,
                          //       border: Border.all(
                          //           width: 2, color: Color(0xFFFEBA00))),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: List.generate(
                          //         textmain1.length,
                          //         (index) => GestureDetector(
                          //               onTap: () {
                          //                 setState(() {
                          //                   selected1 = index;
                          //                   statussubTab1 = !statussubTab1;
                          //                   statussubTab2 = !statussubTab2;
                          //                 });
                          //               },
                          //               child: Column(
                          //                 children: [
                          //                   Container(
                          //                     width: width * 0.45,
                          //                     height: 35,
                          //                     alignment: Alignment.center,
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                             BorderRadius.circular(5),
                          //                         color: selected1 == index
                          //                             ? Color(0xff1380F7)
                          //                             : Colors.white),
                          //                     child: Text(
                          //                       textmain1[index],
                          //                       style: TextStyle(
                          //                           fontSize: 18,
                          //                           fontFamily: 'nsl_bold',
                          //                           color: selected1 == index
                          //                               ? Colors.white
                          //                               : Color(0xFF1380F7)),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             )),
                          //   ),
                          // ),
                          //SizedBox(height: 15),
                          //inputIdorder(width),
                          //SizedBox(height: 35),
                          statussubTab1 == true
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  width: width * 0.95,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        textmain2.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected2 = index;
                                                  orderShowController.onInit();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: width * 0.30,
                                                    height: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: selected2 ==
                                                                index
                                                            ? Color(0xff1380F7)
                                                            : Colors.white),
                                                    child: Text(
                                                      textmain2[index],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'nsl_bold',
                                                          color: selected2 ==
                                                                  index
                                                              ? Colors.white
                                                              : Color(
                                                                  0xFF1380F7)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2, color: Color(0xFFFEBA00))))
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  width: width * 0.95,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        textmain3.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected3 = index;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: width * 0.30,
                                                    height: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: selected3 ==
                                                                index
                                                            ? Color(0xff1380F7)
                                                            : Colors.white),
                                                    child: Text(
                                                      textmain3[index],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'nsl_bold',
                                                          color: selected3 ==
                                                                  index
                                                              ? Colors.white
                                                              : Color(
                                                                  0xFF1380F7)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2, color: Color(0xFFFEBA00)))),
                          SizedBox(height: 15),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),

                              ///margin: EdgeInsets.only(bottom: 200),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 3, color: Color(0xFFFEBA00))),
                              width: width * 0.95,
                              height: 550,
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Usertoken != null
                                      ? Column(
                                          children: [
                                            selected2.toInt() == 0
                                                ? showorder(
                                                    width,
                                                    orderShowController
                                                        .statetList
                                                        .where((p0) =>
                                                            p0.attributes!
                                                                .status
                                                                .toString() ==
                                                            'Pending' ||  p0.attributes!
                                                                .status
                                                                .toString() ==
                                                            'Confirmed' ||  p0.attributes!
                                                                .status
                                                                .toString() ==
                                                            'Processing'||  p0.attributes!
                                                                .status
                                                                .toString() ==
                                                            'Arrived' )
                                                        .toList(),
                                                    Colors.orange)
                                                : selected2.toInt() == 1
                                                    ? showorder(
                                                        width,
                                                        orderShowController
                                                            .statetList
                                                            .where((p0) =>
                                                                p0.attributes!
                                                                    .status
                                                                    .toString() ==
                                                                'Picked')
                                                            .toList(),
                                                        Colors.green)
                                                    : selected2.toInt() == 2
                                                        ? Column()
                                                        : Container(),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(height: 100),
                                            Text('ທ່ານຍັງບໍ່ໄດ້ເຂົ້າສູ່ລະບົບ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 25,
                                                    fontFamily: 'nsl_regular')),
                                            SizedBox(height: 5),
                                            Text('ກະລຸນາເຂົ້າສູ່ລະບົບ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 15,
                                                    fontFamily: 'nsl_regular')),
                                            SizedBox(height: 20),
                                            Container(
                                              width: 280,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Signin_SignUP()));
                                                  },
                                                  child: Text('ເຂົ້າສູ່ລະບົບ',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'nsl_bold')),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              )),
                            ),
                          )
                        ],
                      ))
                    : statusTab3 == true
                        ? Container(
                            margin: EdgeInsets.only(top: 15),
                            width: width * 0.95,
                            height: 600,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    width: 3, color: Color(0xFFFEBA00))),
                            child: Column(children: [
                              SizedBox(height: 20),
                              Container(
                                color: Colors.white,
                                width: 130,
                                height: 130,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: Image.asset('images/logo.jpeg')),
                              ),
                              SizedBox(height: 15),
                              senheing(width),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: width * 0.95,
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 20),
                                      child: Icon(
                                        Icons.home_outlined,
                                        size: 35,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('ເຄເອັນເອັມ ຂົນສົ່ງ',
                                            style: TextStyle(
                                                fontFamily: 'nsl_bold',
                                                color: Colors.black,
                                                fontSize: 19)),
                                        Text('ບ້ານດົງປ່າແຫຼບ, ເມືອງຈັນທະບູລີ',
                                            style: TextStyle(
                                                fontFamily: 'nsl_regular',
                                                color: Colors.grey.shade800,
                                                fontSize: 17)),
                                        Text('ນະຄອນຫຼວງວຽງຈັນ',
                                            style: TextStyle(
                                                fontFamily: 'nsl_regular',
                                                color: Colors.grey.shade800,
                                                fontSize: 17)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              senheing(width),
                              SizedBox(height: 10),
                              Container(
                                width: width * 0.95,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 20),
                                      width: 30,
                                      height: 30,
                                      child:
                                          Image.asset('images/callcenter.png'),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('ສາຍດ່ວນ: ',
                                                style: TextStyle(
                                                    fontFamily: 'nsl_bold',
                                                    color: Colors.grey.shade800,
                                                    fontSize: 19)),
                                            Text('020 56677603',
                                                style: TextStyle(
                                                    fontFamily: 'nsl_regular',
                                                    color: Colors.grey.shade800,
                                                    fontSize: 19)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('ສາຍສຳຮອງ: ',
                                                style: TextStyle(
                                                    fontFamily: 'nsl_bold',
                                                    color: Colors.grey.shade800,
                                                    fontSize: 19)),
                                            Text('020 78370217  / ',
                                                style: TextStyle(
                                                    fontFamily: 'nsl_regular',
                                                    color: Colors.grey.shade800,
                                                    fontSize: 19)),
                                          ],
                                        ),
                                        Text('020 98014785',
                                            style: TextStyle(
                                                fontFamily: 'nsl_regular',
                                                color: Colors.grey.shade800,
                                                fontSize: 19)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                          )
                        : Container(),
          ),
        ),
      ),
    );
  }

  Column showorder(double width, List<OrdershowModel> ordershowModel, color) {
    return Column(
      children: [
        SizedBox(height: 25),
        ordershowModel.length.toInt() != 0 && ordershowModel.isNotEmpty
            ? Obx(() {
                if (orderShowController.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else {
                  return Column(
                      children: List.generate(
                          ordershowModel.length,
                          (index) => Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailOrder(
                                                    idrecipient:
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .recipientId
                                                            .toString(),
                                                    idorder:
                                                        ordershowModel[index]
                                                            .id
                                                            .toString(),
                                                    tonthang:
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .originalBranch
                                                            .toString(),
                                                    piythang:
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .destinationBranch
                                                            .toString(),
                                                    orderItem:
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .orderItem!
                                                            .toList(),
                                                    idcategories:
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .orderItem![0]
                                                            .attribute!
                                                            .categoryId
                                                            .toString(),
                                                  )));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(bottom: 10),
                                        width: width,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade100),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 65,
                                                child: Image.asset(
                                                    'images/box.png')),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 15),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(ordershowModel[index]
                                                        .attributes!
                                                        .invoiceId
                                                        .toString()),
                                                    Text('name: ' +
                                                        ordershowModel[index]
                                                            .attributes!
                                                            .orderItem![0]
                                                            .attribute!
                                                            .parcelName
                                                            .toString()),
                                                  ]),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          height: 30,
                                          child: Text(
                                            ordershowModel[index]
                                                .attributes!
                                                .status
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  BorderRadius.circular(10))))
                                ],
                              )));
                }
              })
            : Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.asset('images/logo.jpeg')),
                  ),
                  SizedBox(height: 10),
                  Text('ບໍ່ມີຂໍ້ມູນ',
                      style: TextStyle(
                          fontFamily: 'nsl_bold',
                          color: Colors.black,
                          fontSize: 18)),
                ],
              ),
      ],
    );
  }

  Container senheing(double width) {
    return Container(
      width: width * 0.95,
      height: 1.1,
      color: Color(0xFF266FFF),
    );
  }

  Container item_main(String image, text, Container container) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade200, width: 2)),
      width: 150,
      child: Column(
        children: [
          container,
          SizedBox(height: 5),
          Text(text, style: TextStyle(fontFamily: 'nsl_bold', fontSize: 16))
        ],
      ),
    );
  }

///////////////////////////////////////////////////
  Container inputIdorder(double screen) {
    return Container(
      width: screen * 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: 'ກະລຸນາໃສ່ເລກໃບບິນ',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'nsl_bold',
            ),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
