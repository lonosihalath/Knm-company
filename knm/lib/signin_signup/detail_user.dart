import 'package:flutter/material.dart';
import 'package:knm/signin_signup/user_account/controller.dart';
import 'package:get/get.dart';

class User_detail extends StatefulWidget {
  const User_detail({Key? key}) : super(key: key);

  @override
  State<User_detail> createState() => _User_detailState();
}

class _User_detailState extends State<User_detail> {
  final Controller controller = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('ຂໍ້ມູນສ່ວນຕົວ',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22)),
        centerTitle: true,
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.10),
                  Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            controller.photoList[0].profile.toString(),
                            fit: BoxFit.cover,
                          ))),
                   SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(15),
                      width: width,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ຊື່ຜູ້ໃຊ້',
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 18),
                              ),
                              Text(
                                controller.photoList[0].name.toString(),
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 18),
                              ),
                            ],
                          ), const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ເພດ',
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                              Text(
                                controller.photoList[0].gender.toString(),
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ວັນເດືອນປີເກີດ',
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                              Text(
                                controller.photoList[0].birth.toString(),
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ເບີໂທ',
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                              Text(
                                controller.photoList[0].phone.toString(),
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ອີເມວ',
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                              Text(
                                controller.photoList[0].email.toString(),
                                style: TextStyle(
                                    fontFamily: 'nsl_bold',
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
