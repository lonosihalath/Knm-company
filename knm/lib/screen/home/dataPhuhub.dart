import 'package:flutter/material.dart';

class Phuhub_Screen extends StatefulWidget {
  const Phuhub_Screen({Key? key}) : super(key: key);

  @override
  State<Phuhub_Screen> createState() => _Phuhub_ScreenState();
}



class _Phuhub_ScreenState extends State<Phuhub_Screen> {
  var currentSelectedValuetel;
  var currentSelectedValueSakah;
  late int _selectedAddress1 = 1;
  static var tel = [
    "020",
    "030",
  ];
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
  static var sakha = [
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
        title: Text(
          'ຂໍ້ມູນຜູ້ຮັບປາຍທາງ',
          style: TextStyle(
              fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 15),
            width: 100,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 18, 44, 243),
                borderRadius: BorderRadius.circular(10)),
            child: Text('ຄົ້ນຫາ',
                style: TextStyle(
                    fontFamily: 'nsl_bold', color: Colors.white, fontSize: 20)),
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 120),
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    textfield('ຂໍ້ມູນຜູ້ຮັບ'),
                    SizedBox(height: 5),
                    name(width),
                     SizedBox(height: 15),
                    Container(
                      width: width,
                      child: Row(
                        children: [
                          selecttel(width),
                          SizedBox(width: 15),
                          phone(width)
                        ],
                      ),
                    ),
                     SizedBox(height: 15),
                     selectsakha(width),
                     SizedBox(height: 15),
                     baibin(width),
                     SizedBox(height: 15),
                     textfield('ຂໍ້ມູນພັດສະດຸ'),
                    SizedBox(height: 10),
                     Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.lightBlue,
                                  value: 1,
                                  groupValue: _selectedAddress1,
                                  toggleable: true,
                                  onChanged: (int? val) {
                                    setState(() {
                                      _selectedAddress1 = val!;
                                      print(val);
                                    });
                                  }),
                              textfiled2('ພັດສະດຸທົ່ວໄປ'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.lightBlue,
                                  value: 2,
                                  groupValue: _selectedAddress1,
                                  toggleable: true,
                                  onChanged: (int? val) {
                                    setState(() {
                                      _selectedAddress1 = val!;
                                      print(val);
                                    });
                                  }),
                              textfiled2('ເອກະສານ'),
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          )),
    );
  }

    Padding textfiled2(text) => Padding(
        padding: const EdgeInsets.all(5.0),
        child:
            Text(text, style: TextStyle(fontFamily: 'nsl_bold', fontSize: 15)),
      );

   Padding textfield(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontFamily: 'nsl_bold', fontSize: 18)),
        ],
      ),
    );
  }

  Container name(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ຊື່ຜູ້ຮັບ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container selecttel(double width) {
    return Container(
      width: width * 0.22,
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
                    tel[0],
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuetel,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuetel = newValue;
                    });
                    print(currentSelectedValuetel);
                  },
                  items: tel.map((String value) {
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

  Container phone(double screen) {
    return Container(
      width: screen * 0.62,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
   Container selectsakha(double width) {
    return Container(
      width: width ,
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
                    'ຟາກລົງສາຂາ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValueSakah,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValueSakah = newValue;
                    });
                    print(currentSelectedValueSakah);
                  },
                  items: sakha.map((String value) {
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
  Container baibin(double screen) {
    return Container(
      width: screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ລະຫັດໃບບິນ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            fillColor: Color(0xFFF4F6FB),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
