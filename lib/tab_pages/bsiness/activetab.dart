import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Active extends StatefulWidget {
  const Active({super.key});

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("zonaluid",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("Status", isEqualTo: "Active")
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
                              'Zonal Manager Name:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['ZName']),
                            Divider(),
                            Text(
                              'Product Name: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['itemName']),
                            // Divider(),
                            // Text(
                            //   'Pcs: ',
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            // Text(snap['PCS']),
                            Divider(),
                            Text(
                              'Zone Area: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(snap['zonalarea']),
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
