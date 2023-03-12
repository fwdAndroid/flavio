import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? uuid;
  //Areas
  String? zonesubarea;
  String? zonalarea;

  //Name

  String? ZName;
  String SUBZONEName; //Retailer Name
  //Area Manager
  String? Status;
  //Items
  String itemName;
  int itemPrice;
  int itemQuantity;
  //Auth ID
  String? zonalsubuid;

  String? zonaluid;

  OrderModel(
      {required this.SUBZONEName,
      required this.itemQuantity,
      required this.itemName,
      required this.itemPrice,
      this.uuid,
      this.Status,
      this.zonesubarea,
      this.zonalarea,
      this.ZName,
      this.zonalsubuid,
      this.zonaluid});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'itemQuantity': itemQuantity,
        "itemName": itemName,
        'SUBZONEName': SUBZONEName,
        "itemPrice": itemPrice,
        "Status": Status,
        "zonesubarea": zonesubarea,
        "zonalarea": zonalarea,
        "ZName": ZName,
        "zonalsubuid": zonalsubuid,
        "zonaluid": zonaluid
      };

  ///
  static OrderModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return OrderModel(
      zonaluid: snapshot['zonaluid'],
      zonalsubuid: snapshot['zonalsubuid'],
      zonalarea: snapshot['Zonal Area'],
      zonesubarea: snapshot['Sub Zone Area'],
      Status: snapshot['Status'],
      itemQuantity: snapshot['itemQuantity'],
      itemPrice: snapshot['itemPrice'],
      itemName: snapshot['itemName'],
      SUBZONEName: snapshot['Sub Zone Manager'],
      ZName: snapshot['Zonal Manager Name'],
    );
  }
}
