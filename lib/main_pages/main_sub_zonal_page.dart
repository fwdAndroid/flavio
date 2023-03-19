import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavio/login_screens/login_screen.dart';
import 'package:flavio/order/product_detail.dart';
import 'package:flavio/tabs/sub_zonal_orders_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainSubZonelPage extends StatefulWidget {
  final area;
  final name;
  const MainSubZonelPage({super.key, required this.area, required this.name});

  @override
  State<MainSubZonelPage> createState() => _MainSubZonelPageState();
}

class _MainSubZonelPageState extends State<MainSubZonelPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Sub Zonal App",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => SubZonalOrderTab()));
                    },
                    child: Text(
                      "History",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut().then((value) => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Login()),
                                (route) => false)
                          });
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              backgroundColor: Colors.purple,
            ),
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("inventory")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    Center(
                      child: Text("No Product Listed"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snap = snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Item Name:" + snap['ItemName']),
                                Text("Item Rate:" +
                                    snap['itemPrice'].toString()),
                              ],
                            ),
                            trailing: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => ProductDetail(
                                                area: widget.area,
                                                name: widget.name,
                                                uuid: snap['uuid'],
                                                itemCost: snap['itemCost'],
                                                itemName: snap['ItemName'],
                                                itemPrice: snap['itemPrice'],
                                                // pcs: snap['pcs'],
                                                itemQuatity:
                                                    snap['itemQuantity'],
                                              )));
                                },
                                child: Text("View")),
                          ),
                        );
                      });
                }));
  }
}
