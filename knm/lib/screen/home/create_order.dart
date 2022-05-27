import 'package:flutter/material.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  var currentSelectedValuetel;
  var currentSelectedValueTonthang;
  var currentSelectedValuepiythang;
  var currentSelectedValuecategories;
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
  static var categories = [
    "ເຄື່ອງປະດັບ",
    "ເຄື່ອງໃຊ້ໄຟຟ້າ",
    "ເຄື່ອງນຸ່ງຫົ່ມ",
    "ອຸປະກອນຊ່າງ",
    "ເຄື່ອງຈັກ",
    "ເຄື່ອງຈັກ",
    "ໂທລະສັບ",
    "ຄອມພີວເຕີ້",
    "ເຄື່ອງສຳອາງ",
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
          'ສ້າງໃບບິນດ້ວຍຕົນເອງ',
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
            child: Text('ບັນທຶກ',
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
                    address(width),
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
                          textfiled2('ປະເພດພັດສະດຸ'),
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
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selectsakhaTonthang(width),
                        selectsakhapiythang(width)
                      ],
                    ),
                    SizedBox(height: 17),
                    categorie(width),
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [widthheigth(width), numnuk(width)],
                    ),
                    SizedBox(height: 17),
                    Container(
                      width: width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1,color: Colors.red)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ໝາຍເຫດ',
                              style: TextStyle(
                                  fontFamily: 'nsl_bold', fontSize: 20,color: Colors.red)),
                          Text('ຄ່າບໍລິການແມ່ນຕ້ອງອິງຕາມການຄິດໄລ່ຕົວຈິງຂອງພະນັກງານ ເຄເອັນເອັມ',
                              style: TextStyle(
                                  fontFamily: 'nsl_bold', fontSize: 14)),
                        ],
                      ),
                    )
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
      width: width * 0.20,
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
      width: screen * 0.65,
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

  Container address(double screen) {
    return Container(
      width: screen,
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
            hintText: 'ທີ່ຢູ່ປັດຈຸບັນຜູ້ຮັບ',
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'nsl_bold'),
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container selectsakhaTonthang(double width) {
    return Container(
      width: width * 0.43,
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

  Container selectsakhapiythang(double width) {
    return Container(
      width: width * 0.43,
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

  Container categorie(double width) {
    return Container(
      width: width,
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
                    'ເລືອກໝວດໝູ່ເຄື່ອງ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nsl_bold',
                        color: Colors.grey.shade600),
                  ),
                  value: currentSelectedValuecategories,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValuecategories = newValue;
                    });
                    print(currentSelectedValuecategories);
                  },
                  items: categories.map((String value) {
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

  Container widthheigth(double screen) {
    return Container(
      width: screen * 0.43,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ກ້ວາງ + ສູງ +ຍາວ',
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

  Container numnuk(double screen) {
    return Container(
      width: screen * 0.43,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'nsl_bold',
              color: Colors.grey.shade800),
          decoration: InputDecoration(
            hintText: 'ນໍ້າໜັກຂອງພັດສະດຸ',
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
