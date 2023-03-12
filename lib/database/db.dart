import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavio/model/orders_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addOrder(
      {required String itemName,
      required String SubZoneName,
      required int itemQuantity,
      required int itemPrice,
      String? ZoneName,
      String? zonaluid,
      String? Status,
      String? subzoneuid,
      String? zonearea,
      String? subzonearea}) async {
    String res = 'Some error occured';

    try {
      var uuid = Uuid().v1();

      OrderModel userModel = OrderModel(
        SUBZONEName: SubZoneName,
        itemName: itemName,
        itemPrice: itemPrice,
        itemQuantity: itemQuantity,
        Status: Status,
        zonaluid: zonaluid,
        ZName: ZoneName,
        zonalarea: zonearea,
        zonesubarea: subzonearea,
        zonalsubuid: subzoneuid,
        uuid: uuid,

        //Auth
      );
      await firebaseFirestore
          .collection('orders')
          .doc(uuid)
          .set(userModel.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
