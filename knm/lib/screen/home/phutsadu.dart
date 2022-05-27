import 'package:flutter/material.dart';

class Phutsadu extends StatefulWidget {
  final int index;
  const Phutsadu({Key? key, required this.index}) : super(key: key);

  @override
  State<Phutsadu> createState() => _PhutsaduState();
}

class _PhutsaduState extends State<Phutsadu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    late int selected = 0;
    late List<String> textmain = ['ຂ້ອຍຈັດສົ່ງ', 'ສົ່ງໃຫ້ຂ້ອຍ'];
    return Column(
      children: [
        Container(
          width: width * 0.45,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected == widget.index ? Color(0xff1380F7) : Colors.white),
          child: Text(
            textmain[widget.index],
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'nsl_bold',
                color: selected == widget.index ? Colors.white : Color(0xFF1380F7)),
          ),
        ),
      ],
    );
  }
}
