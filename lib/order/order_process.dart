import 'package:flavio/database/db.dart';
import 'package:flavio/main_pages/main_sub_zonal_page.dart';
import 'package:flavio/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrderProces extends StatefulWidget {
  final String itemName, uuid;
  final area;
  final name;
  final int itemPrice, itemQuatity, itemCost;
  String zonalManagerName;
  OrderProces(
      {super.key,
      required this.area,
      required this.zonalManagerName,
      required this.itemCost,
      required this.itemName,
      required this.itemPrice,
      required this.itemQuatity,
      required this.name,
      required this.uuid});

  @override
  State<OrderProces> createState() => _OrderProcesState();
}

class _OrderProcesState extends State<OrderProces> {
  TextEditingController _pcsControleler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("Order Process Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                "Order Precurement Detail",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Zonal Manager Name",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                widget.zonalManagerName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Divider(),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Name",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                widget.itemName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Divider(),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Cost Per Quantity",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                widget.itemPrice.toString(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Divider(),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Text(
              "Write down the product quantity you want",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 4),
            child: TextFormField(
              controller: _pcsControleler,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: widget.itemQuatity.toString(),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 30,
          ),
          Center(
              child: ElevatedButton(
            onPressed: () async {
              if (_pcsControleler.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Quantity is Required")));
              } else {
                await Database().addOrder(
                  itemCost: addCost(
                      widget.itemPrice, int.parse(_pcsControleler.text)),
                  zonearea: widget.area,
                  subzonearea: widget.area,
                  itemPrice: widget.itemPrice,
                  SubZoneName: widget.name,
                  ZoneName: widget.zonalManagerName,
                  Status: "Pending",
                  itemName: widget.itemName,
                  itemQuantity: int.parse(_pcsControleler.text),
                );

                Customdialog().showInSnackBar("Order is Placed", context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => MainSubZonelPage(
                              area: widget.area,
                              name: widget.name,
                            )));
              }
            },
            child: Text("Place Order"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                fixedSize: Size(250, 50),
                shape: StadiumBorder()),
          ))
        ],
      ),
    );
  }

  int addCost(int price, int quantity) {
    int price = widget.itemPrice;
    int quantity = int.parse(_pcsControleler.text);

    int total = price * quantity;
    return total;
  }
}
