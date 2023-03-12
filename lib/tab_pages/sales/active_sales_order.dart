import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class ActiveSalesOrders extends StatefulWidget {
  final Uuid;
  const ActiveSalesOrders({super.key, required this.Uuid});

  @override
  State<ActiveSalesOrders> createState() => _ActiveSalesOrdersState();
}

class _ActiveSalesOrdersState extends State<ActiveSalesOrders> {
  @override
  Widget build(BuildContext context) {
    print(widget.Uuid);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("Status", isEqualTo: "Active")
            .where("salesUid",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snap = snapshot.data!.docs[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Territory Manager Name:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['Territory Manager Name']),
                            Divider(),
                            Text(
                              'Product Name: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['productName']),
                            // Divider(),
                            // Text(
                            //   'Pcs: ',
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            // Text(snap['PCS']),
                            // Divider(),
                            Text(
                              'Area: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['Territory Area']),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
          ;
        },
      ),
    );
  }
}
