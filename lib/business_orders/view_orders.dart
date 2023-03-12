import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_management/business_orders/business_order_detail.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';
import 'package:order_management/order/regional_order_detail_page.dart';
import 'package:order_management/order/sales_officer_order_detail_page.dart';

class ViewOrderPage extends StatefulWidget {
  final email, name, area;
  const ViewOrderPage(
      {super.key, required this.area, required this.name, required this.email});

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.area);
    print(widget.name);
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Order Detail"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("Status", isEqualTo: "Active")
              .where("Business Manager Name", isEqualTo: widget.name)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              Center(child: Text("No Thing Found"));
            } else if (!snapshot.hasData) {
              Center(child: Text("No Thing Found Data"));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snap = snapshot.data!.docs[index];

                  return Card(
                      child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Regional Manager Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Regional Manager Name'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Regional Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Regional Area'])),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => BussinsssOrderDetail(
                                    distributorname: widget.name,
                                    distributorarea: widget.area,
                                    distributoremail: widget.email,
                                    uuid: snap['uuid'])));
                      },
                      child: Text("View"),
                    ),
                  ));
                });
          }),
    );
  }
}
