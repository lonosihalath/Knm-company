import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:knm/signin_signup/signIN_signUp.dart';

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
  late List<String> textmain = ['ໜ້າຫຼັກ', 'ພັດສະດຸ', 'ຊ່ວຍເຫຼືອ'];
  late String texttap = '';
  final List<String> imgList = ['images/lazada3.jpg', 'images/lazada4.jpg'];
  late int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
       
        //extendBodyBehindAppBar: true,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[SliverAppBar(
              backgroundColor: Color.fromARGB(255, 22, 141, 239),
              elevation: 0,
              snap: false,
              floating: true,
              bottom: PreferredSize(preferredSize: Size.fromHeight(40),child: 
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                width: width,
                height: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 3),
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
              
            )];
          },
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
                                              Signin_SignUP()));
                                },
                                child: Container(
                                  width: 60,
                                  child: Image.asset('images/profile.png'),
                                ),
                              )
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
                                spacing: 45,
                                alignment: WrapAlignment.start,
                                children: [
                                  item_main('images/kong.png', 'ຝາກດຄື່ອງເອງ'),
                                  item_main(
                                      'images/windowss.png', 'ພັດສະດຸຂອງຂ້ອຍ'),
                                  item_main('images/caculator.png',
                                      'ຄິດໄລ່ຄ່າຂົນສົ່ງ'),
                                  item_main('images/sakha.png', 'ຂໍ້ມູນສາຂາ'),
                                  item_main('images/car.png', 'Prackink'),
                                  item_main(
                                      'images/preson.png', 'ຂໍ້ມູນຜູ້ຮັບ'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : statusTab2 == true
                      ? Center(child: Text('data2'))
                      : statusTab3 == true
                          ? Center(child: Text("data3"))
                          : Container(),
            ),
          ),
        ),
        ));
  }

  Container item_main(String image, text) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade200, width: 2)),
      width: 140,
      child: Column(
        children: [
          Container(
              width: 130,
              height: 110,
              child: Image.asset(image, fit: BoxFit.contain)),
          SizedBox(height: 5),
          Text(text, style: TextStyle(fontFamily: 'nsl_bold', fontSize: 16))
        ],
      ),
    );
  }
}
