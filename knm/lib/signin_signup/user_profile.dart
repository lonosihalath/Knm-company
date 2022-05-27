import 'package:flutter/material.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({Key? key}) : super(key: key);

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
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
            SizedBox(height: height*0.10),
            Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      color: Colors.white),
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
                      border: Border.all(width: 2,color: Colors.blue),
                      color: Colors.white),
                        child: Icon(Icons.camera_enhance, color: Colors.blue,size: 22)))
              ],
            ),
            SizedBox(height:10),
            Text('ທ ໂລ່ໂນ້ ສີຫາລາດ', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 18)),
            Text('ເບີໂທ: 020 56677603', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 18)),
             SizedBox(height:40),
            Container(
              width: width,
              padding: EdgeInsets.all(20),
             child: Column(
               children: [
                 Container(
                   child: Row(
                     children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.person_sharp, color: Colors.white,size: 35)),
                       TextButton(onPressed: (){}, child: Text('ຂໍ້ມູນບັນຊີ', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 20),))
                     ],
                   ),
                 ),
                 SizedBox(height:10),
                 Container(
                   child: Row(
                     children: [
                       IconButton(onPressed: (){}, icon: Container(width: 30,height: 35,child: Image.asset('images/callcenter.png',color: Colors.white,))),
                       TextButton(onPressed: (){}, child: Text('ຕິດຕໍ່ພວກເຮົາ', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 20),))
                     ],
                   ),
                 ),
                 SizedBox(height:10),
                 Container(
                   child: Row(
                     children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.list_alt_rounded, color: Colors.white,size: 35)),
                       TextButton(onPressed: (){}, child: Text('ຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂ', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 20),))
                     ],
                   ),
                 ),
                 SizedBox(height:10),
                 Container(
                   child: Row(
                     children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.logout, color: Colors.white,size: 35)),
                       TextButton(onPressed: (){}, child: Text('ອອກຈາກລະບົບ', style: TextStyle(color: Colors.white,fontFamily: 'nsl_bold',fontSize: 20),))
                     ],
                   ),
                 ),
               ],
             ),
            )
          ],
        )),
      ),
    );
  }
}
