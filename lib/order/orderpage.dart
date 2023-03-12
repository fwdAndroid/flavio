import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavio/database/db.dart';
import 'package:flavio/main_pages/main_sub_zonal_page.dart';
import 'package:flavio/widgets/utils.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final String itemName, uuid;
  final area;
  final name;
  final int itemPrice, itemQuatity;
  const OrderPage(
      {super.key,
      required this.name,
      required this.itemQuatity,
      required this.area,
      required this.uuid,
      // required this.pcs,
      required this.itemPrice,
      required this.itemName});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _pcsControleler = TextEditingController();
  var values;

  @override
  Widget build(BuildContext context) {
    print(widget.area);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text("Order Page"),
        ),
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Image.asset(
              "assets/splash.png",
              height: 200,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("usersmanagers")
                  .where("area", isEqualTo: widget.area)
                  .where("type", isEqualTo: "Zone Manager")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  const Text("Loading.....");
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Zone Manager Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: DropdownButton(
                            isExpanded: true,
                            value: values,
                            items: snapshot.data!.docs.map((value) {
                              debugPrint('makeModel: ${value.get('name')}');
                              return DropdownMenuItem(
                                value: value.get('name'),
                                child: Text(
                                  '${value.get('name')}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              debugPrint('makeModel selected: $value');
                              setState(
                                () {
                                  // Selected value will be stored
                                  values = value;
                                  // Default dropdown value won't be displayed anymore
                                },
                              );
                            },
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Item Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            widget.itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 14),
                          child: Text(
                            "Item Quantity",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            widget.itemQuatity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      // Container(
                      //     margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                      //     child: Text(
                      //       "Number of Pcs",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w700, fontSize: 17),
                      //     )),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15, right: 15, top: 4),
                      //   child: TextFormField(
                      //     controller: _pcsControleler,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       hintText: widget.pcs,
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 4),
                          child: Text(
                            "Rate",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            widget.itemPrice.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          await Database().addOrder(
                            zonearea: widget.area,
                            subzonearea: widget.area,
                            itemPrice: widget.itemPrice,
                            SubZoneName: widget.name,
                            Status: "Active",
                            itemName: widget.itemName,
                            itemQuantity: widget.itemQuatity,
                          );

                          Customdialog()
                              .showInSnackBar("Database Added", context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => MainSubZonelPage()));
                        },
                        child: Text("Place Order"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            fixedSize: Size(250, 50),
                            shape: StadiumBorder()),
                      ))
                    ],
                  );
                }
                return Center(child: Text("No Product Added"));
              })
        ]));
  }
}
