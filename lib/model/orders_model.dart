import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? uuid;
  //Areas
  String? teritoryArea;
  String? busnissarea;
  String? zonalarea;
  String? regionalarea;
  String? salesaofficerarea;
  String? distributorarea;
  String? retailerarea;
  String? areamanager;
  //Name
  String? tName;
  String? bName;
  String? ZName;
  String? REName; //Regional manager Name
  String RName; //Retailer Name
  String? SName;
  String? DName;
  String? Status;
  String? AName; //Area Manager
  //Items
  String productName;
  String rate;
  String pcs;
  String dimensions;
  //Auth ID
  String? uid;
  String? distributorid;
  String? salesUid;
  String? territoryUid;
  String? areauid;
  String? zonaluid;
  String? regionaluid;
  String? businessuid;
  OrderModel(
      {required this.RName,
      this.regionaluid,
      this.businessuid,
      required this.productName,
      required this.rate,
      required this.dimensions,
      required this.pcs,
      this.teritoryArea,
      this.areauid,
      this.uuid,
      this.salesUid,
      this.distributorid,
      this.Status,
      this.areamanager,
      this.busnissarea,
      this.distributorarea,
      this.regionalarea,
      this.retailerarea,
      this.salesaofficerarea,
      this.zonalarea,
      this.tName,
      this.AName,
      this.DName,
      this.REName,
      this.SName,
      this.ZName,
      this.uid,
      this.bName,
      this.territoryUid,
      this.zonaluid});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'regionaluid': regionaluid,
        'areauid': 'areauid',
        'salesUid': salesUid,
        'distributorid': distributorid,
        'rate': rate,
        'dimensions': dimensions,
        'productName': productName,
        'PCS': pcs,
        'businessuid': businessuid,
        'Status': Status,
        'Territory Area': teritoryArea,
        'Area Area': areamanager,
        'Business Area': busnissarea,
        'Distributor Area': distributorarea,
        'Regional Area': regionalarea,
        'Retailer Area': retailerarea,
        'Sales Officer Area': salesaofficerarea,
        'Zonal Area': zonalarea,
        //Name
        'RetailerName': RName,
        'Territory Manager Name': tName,
        'Business Manager Name': bName,
        'Zonal Manager Name': ZName,
        'Distributor Manager Name': DName,
        'Sales Officer Name': SName,
        'Regional Manager Name': REName,
        'Area Manager Name': AName,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'territoryUid': territoryUid,
        'zonaluid': zonaluid,
        'businessuid': businessuid
      };

  ///
  static OrderModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return OrderModel(
        distributorid: snapshot['distributorid'],
        salesUid: snapshot['salesUid'],
        regionaluid: snapshot['regionaluid'],
        Status: snapshot['Status'],
        uid: snapshot['uid'],
        areauid: snapshot['areauid'],
        rate: snapshot['rate'],
        dimensions: snapshot['dimensions'],
        RName: snapshot['RetailerName'],
        productName: snapshot['productName'],
        pcs: snapshot['PCS'],
        territoryUid: snapshot['territoryUid'],
        //Areas
        teritoryArea: snapshot['Territory Area'],
        areamanager: snapshot['Area Area'],
        busnissarea: snapshot['Business Area'],
        distributorarea: snapshot['Distributor Area'],
        regionalarea: snapshot['Regional Area'],
        retailerarea: snapshot['Retailer Area'],
        salesaofficerarea: snapshot['Sales Officer Area'],
        zonalarea: snapshot['Zonal Area'],
        //Name
        tName: snapshot['Territory Manager Name'],
        bName: snapshot['Business Manager Name'],
        ZName: snapshot['Zonal Manager Name'],
        DName: snapshot['Distributor Manager Name'],
        SName: snapshot['Sales Officer Name'],
        REName: snapshot['Regional Manager Name'],
        AName: snapshot['Area Manager Name'],
        uuid: snapshot['uuid'],
        zonaluid: snapshot['zonaluid'],
        businessuid: snapshot['businessuid']);
  }
}
