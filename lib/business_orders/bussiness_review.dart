import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavio/widgets/utils.dart';
import 'package:flavio/zonals/main_zonal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BusinessReview extends StatefulWidget {
  final itemName;
  final itemQuanitity;
  final uuid;
  final subzonearea;
  final itemPrice;

  const BusinessReview(
      {super.key,
      required this.itemPrice,
      required this.uuid,
      required this.subzonearea,
      required this.itemQuanitity,
      required this.itemName});

  @override
  State<BusinessReview> createState() => _BusinessReviewState();
}

class _BusinessReviewState extends State<BusinessReview> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _pcController = TextEditingController();
    print(widget.itemName);
    print(widget.subzonearea);
    print(widget.uuid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Zonal Manager Review Page"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("usersmanagers")
              .where("area", isEqualTo: widget.subzonearea)
              .where("type", isEqualTo: "Zone Manager")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            print(snapshot);

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> snap =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Zonal Manager Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Zonal Manager Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['email'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Zonal Manager Area",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['area'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.uuid)
                                .update({
                              "Status": "Proceed",
                              "ZName": snap['name'],
                              "zonaluid": FirebaseAuth.instance.currentUser!.uid
                            });
                            Customdialog().showInSnackBar(
                                "Order is Review by Me and I sent it to admin panel",
                                context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainZonalPage()));
                          },
                          child: Text('Proceed'),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 50),
                              backgroundColor: Colors.purple,
                              shape: StadiumBorder()),
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
