import 'package:flutter/material.dart';

class Callcenter_Screen extends StatefulWidget {
  const Callcenter_Screen({Key? key}) : super(key: key);

  @override
  State<Callcenter_Screen> createState() => _Callcenter_ScreenState();
}

class _Callcenter_ScreenState extends State<Callcenter_Screen> {
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
        title: Text(
          'ຕິດຕໍ່ພວກເຮົາ',
          style: TextStyle(
              fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
  body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Center(
            child:  Container(
                            width: width * 0.95,
                            height: 500,
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
                          ),
          )),
    );
  }
}
