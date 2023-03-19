import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavio/tabs/sub_zonal_orders_tabs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubZoneInvoice extends StatefulWidget {
  const SubZoneInvoice({super.key});

  @override
  State<SubZoneInvoice> createState() => _SubZoneInvoiceState();
}

class _SubZoneInvoiceState extends State<SubZoneInvoice> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => SubZonalOrderTab()));
                    },
                    child: Text(
                      "Order History",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              title: Text(
                "Invoice",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.purple,
            ),
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("orders").snapshots(),
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
                            title: Text("Zonal Manager Name: " + snap['ZName']),
                            subtitle: Text(
                              "Product Name: " + snap['itemName'].toString(),
                            ),
                            trailing: TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(
                                            child: const Text(
                                              'Order Invoice',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Zonal Manager Name",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snap['ZName'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Product Name",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snap['itemName'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Item Quantity",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snap['itemQuantity']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Product Price",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snap['itemCost'].toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Product Order Date",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                //                            DateFormat.yMMMMd().format(
                                                // DateTime.fromMillisecondsSinceEpoch(
                                                //     int.parse(e.dateTime)))),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    DateFormat.yMMMd()
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                int.parse(snap[
                                                                    'dateTime'])))
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Order Status",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                //                            DateFormat.yMMMMd().format(
                                                // DateTime.fromMillisecondsSinceEpoch(
                                                //     int.parse(e.dateTime)))),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    snap['Status'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text("View Invoice")),
                          ),
                        );
                      });
                }));
  }

  void invoice() {}
}
