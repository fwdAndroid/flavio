import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavio/business_orders/business_order_detail.dart';
import 'package:flutter/material.dart';

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
              .where("Status", isEqualTo: "Pending")
              .where("zonalarea", isEqualTo: widget.area)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.hasData) {
              Text("sadd");
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
                          "Sub Zonal Manager  Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['SUBZONEName'].toString())),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Zonal Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['zonalarea'])),
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
