import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/business_orders/view_orders.dart';
import 'package:order_management/mains_screen.dart';
import 'package:order_management/tabs/business_tab.dart';

class MainBusinessPage extends StatefulWidget {
  const MainBusinessPage({super.key});

  @override
  State<MainBusinessPage> createState() => _MainBusinessPageState();
}

class _MainBusinessPageState extends State<MainBusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => BusinessTab()));
                },
                child: Text(
                  "History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => MainScreen()));
                  });
                },
                child: Text(
                  "LogOut",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
          title: Text("Business Manager Page"),
          backgroundColor: Colors.purple,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("usersmanagers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              var ds = snapshot.data;

              if (!snapshot.hasData) {
                Center(
                  child: Text("No Product Listed"),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                "Business Manager Profile Info:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Business Manager Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text("Name:" + ds['name']),
                            Divider(),
                            Text(
                              "Business Manager Email:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['email']),
                            Divider(),
                            Text(
                              "Business Manager Area:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['area']),
                            Divider(),
                            Text(
                              "Business Manager Password:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['password']),
                            // trailing: TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (builder) => ProductDetail(
                            //                     area: widget.area,
                            //                     name: widget.name,
                            //                     uuid: snap['uuid'],
                            //                     rate: snap['rate'],
                            //                     dimension: snap['dimensions'],
                            //                     pcs: snap['pcs'],
                            //                     productname: snap['productname'],
                            //                   )));
                            //     },
                            //     child: Text("View")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(ds['email']);
                      // FirebaseFirestore.instance
                      //     .collection("orders")
                      //     .doc(ds['uuid'])
                      //     .update({
                      //   "businessuid": FirebaseAuth.instance.currentUser!.uid
                      // });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ViewOrderPage(
                                    area: ds['area'],
                                    email: ds['email'],
                                    name: ds['name'],
                                  )));
                    },
                    child: Text("View Orders"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        fixedSize: Size(200, 50),
                        shape: StadiumBorder()),
                  )
                ],
              );
            }));
    ;
  }
}
