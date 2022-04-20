import 'package:cloud_firestore/cloud_firestore.dart';

enum FsDocPaymentType {
  name,
}

class PaymentTypeModel {
  PaymentTypeModel({
    this.id,
    required this.name,
  });

  PaymentTypeModel.fromDocumentSnapshot({
    required DocumentSnapshot documentSnapshot,
  }) {
    id = documentSnapshot.id;
    name = documentSnapshot[FsDocPaymentType.name.name] as String;
  }

  String? id;
  String? name;
}
