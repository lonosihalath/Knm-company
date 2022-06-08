import 'package:flutter/material.dart';

class Kidlailakha_screen extends StatefulWidget {
  const Kidlailakha_screen({Key? key}) : super(key: key);

  @override
  State<Kidlailakha_screen> createState() => _Kidlailakha_screenState();
}

class _Kidlailakha_screenState extends State<Kidlailakha_screen> {
  TextEditingController width1 = TextEditingController();
  TextEditingController heigth = TextEditingController();
  TextEditingController width2 = TextEditingController();
  TextEditingController weigth = TextEditingController();

  int price = 6000;
  double amout = 0;
  var currentSelectedValueTonthang;
  var currentSelectedValuepiythang;
  static var datasakhaTonthang = [
    "ພະໄຊ",
    "ດອນໜູນ",
    "ຊຽງຄວນ",
  ];
  static var datasakhapiythang = [
    "ພະໄຊ",
    "ດອນໜູນ",
    "ຊຽງຄວນ",
  ];

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
        title: Text('ຄິດໄລ່ລາຄາຂົນສົ່ງ',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22)),
        centerTitle: true,
      ),
      bottomNavigationBar: bottomNavigationBar(width),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.10),
                Container(
                  width: width,
                  padding:
                      EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFFEBA00), width: 3)),
                  child: Column(
                    children: [
                      textfield('ຕົ້ນທາງ'),
                      SizedBox(height: 5),
                      selectsakhaTonthang(),
                      SizedBox(height: 5),
                      textfield('ປາຍທາງ'),
                      SizedBox(height: 5),
                      selectsakhapiythang(),
                      SizedBox(height: 5),
                      textfield('ນໍ້າໜັກລວມ'),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          inputnumnuk(width),
                          SizedBox(
                            width: 15,
                          ),
                          Text('kg',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          textfield('ຂະໜາດຂອງພັດສະດຸ ຄິດໄລ່ເປັນ'),
                          Text('cm',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          inputwidth(width),
                          inputR(width),
                          inputheight(width)
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width,
                        height: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF0D4AF1), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(amout.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('₭',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'nsl_bold'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Container bottomNavigationBar(double width) {
    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: 75,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.30,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0D4AF1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                      side: BorderSide(color: Color(0xFFFEBA00), width: 2))),
              child: Text('ລ້າງຂໍ້ມູນ',
                  style: TextStyle(fontSize: 16, fontFamily: 'nsl_bold')),
              onPressed: () {},
            ),
          ),
          Container(
            width: width * 0.60,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0D4AF1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                      side: BorderSide(color: Color(0xFFFEBA00), width: 2))),
              child: Text('ຄຳນວນລາຄາ',
                  style: TextStyle(fontSize: 16, fontFamily: 'nsl_bold')),
              onPressed: () {
                setState(() {
                  amout = double.parse(width1.text.toString()) *
                      double.parse(width2.text.toString()) *
                      double.parse(heigth.text.toString()); 
                  amout = amout / 6000; 
                  amout = amout * price;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding textfield(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontFamily: 'nsl_bold', fontSize: 18),
          ),
        ],
      ),
    );
  }

  Container selectsakhaTonthang() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    'ເລືອກສາຂາຕົ້ນທາງ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValueTonthang,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValueTonthang = newValue;
                    });
                    print(currentSelectedValueTonthang);
                  },
                  items: datasakhaTonthang.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container selectsakhapiythang() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  fillColor: Color(0xFFF4F6FB),
                  filled: true,
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'nsl_bold',
                      color: Colors.grey.shade800),
                  hint: Text(
                    'ເລືອກສາຂາປາຍທາງ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuepiythang,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuepiythang = newValue;
                    });
                    print(currentSelectedValuepiythang);
                  },
                  items: datasakhapiythang.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container inputnumnuk(double screen) {
    return Container(
      width: screen * 0.70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: weigth,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ນໍ້າໜັກກ່ອງ',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'nsl_bold',
            ),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputwidth(double screen) {
    return Container(
      width: screen * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: width1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ລວງຍາວ',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'nsl_bold',
            ),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputR(double screen) {
    return Container(
      width: screen * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: width2,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ລວງກ້ວາງ',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'nsl_bold',
            ),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container inputheight(double screen) {
    return Container(
      width: screen * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          controller: heigth,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ລວງສູງ',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'nsl_bold',
            ),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
