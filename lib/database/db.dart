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
      required int itemCost,
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
          dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
          SUBZONEName: SubZoneName,
          itemName: itemName,
          itemPrice: itemPrice,
          itemQuantity: itemQuantity,
          Status: Status,
          zonaluid: zonaluid,
          ZName: ZoneName,
          zonalarea: zonearea,
          zonesubarea: subzonearea,
          zonalsubuid: FirebaseAuth.instance.currentUser!.uid,
          uuid: uuid,
          itemCost: itemCost

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
