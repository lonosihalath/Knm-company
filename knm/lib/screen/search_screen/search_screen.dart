import 'package:flutter/material.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/screen/order/show_order_model.dart';
import 'package:knm/screen/order/widget_order.dart/order_widget.dart';

class Search_Screen extends StatefulWidget {
  final List<OrdershowModel> data;
  const Search_Screen({Key? key, required this.data}) : super(key: key);

  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController dataSearch = TextEditingController();

  final FocusNode _node = FocusNode();
  List<OrdershowModel> _searchname = [];
  String name = '';
  @override
  Widget build(BuildContext context) {
    //print('Search====> ' + '${_searchname.length}');
    double screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            )),
        title: Text('ຂໍ້ມູນການຄົ້ນຫາ',
            style: TextStyle(
                fontFamily: 'nsl_bold', color: Colors.white, fontSize: 22)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Container(
                //margin: const EdgeInsets.only(top: 20,bottom: 20),
                child: Center(
                  child: Column(
                    children: [
              OrderWidget(ordershowModel: widget.data, color: Colors.orange, width: screen),
                    ],
                  ),
                )),
          ),
      ),
    );
  }

  AppBar Custom_appbar_contineu(BuildContext context, double screen) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Image.asset('images/Logo1.png', width: 104),
      leading: IconButton(
        icon: Image.asset('images/back2.png',width: 21),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 15),
          width: screen * 0.90,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screen * 0.70,
                child: TextFormField(
                  controller: dataSearch,
                  autofocus: true,
                  style: const TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (String value) {
                    name = dataSearch.text;
                    _node.unfocus();
                    if (name != '') {
                      setState(() {
                        _searchname = widget.data
                            .where((element) => element.attributes!.orderItem![0].attribute!.parcelName!
                                .toLowerCase()
                                .contains(dataSearch.text.toLowerCase()))
                            .toList();
                      });
                    } else {
                      setState(() {
                        name = '';
                      });
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search Product',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              GestureDetector(
               onTap: (){
                  name = dataSearch.text;
                    _node.unfocus();
                    if (name != '') {
                      setState(() {
                        _searchname = widget.data
                            .where((element) =>  element.attributes!.orderItem![0].attribute!.parcelName!
                                .toLowerCase()
                                .contains(name.toLowerCase()))
                            .toList();
                      });
                    } else {
                      setState(() {
                        name = '';
                      });
                    }
               },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  width: 40,
                ),
              ),
            ],
          ),
        ),
      ),
     
    );
  }
}
