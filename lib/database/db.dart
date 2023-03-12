import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavio/model/orders_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addOrder(
      {required String rate,
      required String RName,
      required String productname,
      required String dimension,
      required String pcs,
      String? DName,
      String? businessuid,
      String? areauid,
      String? distributorid,
      String? Status,
      String? regionaluid,
      String? salesUid,
      String? territoryUid,
      String? zonaluid,
      String? retailerarea,
      String? distributorarea}) async {
    String res = 'Some error occured';

    try {
      var uuid = Uuid().v1();

      OrderModel userModel = OrderModel(
        teritoryArea: '',
        territoryUid: territoryUid,
        areamanager: '',
        busnissarea: '',
        Status: Status,
        regionalarea: '',
        retailerarea: retailerarea,
        zonalarea: '',
        salesaofficerarea: '',
        distributorarea: distributorarea,
        areauid: areauid,
        regionaluid: regionaluid,
        tName: '',
        AName: '',
        bName: '',
        businessuid: businessuid,
        REName: '',
        RName: RName,
        ZName: '',
        SName: '',
        DName: DName,
        uuid: uuid,
        pcs: pcs,
        productName: productname,
        zonaluid: zonaluid,
        dimensions: dimension,
        rate: rate,
        //Auth
        salesUid: salesUid,
        distributorid: distributorid,
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
