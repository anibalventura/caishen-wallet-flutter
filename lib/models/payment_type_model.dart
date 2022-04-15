import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentTypeEnum {
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
    name = documentSnapshot[PaymentTypeEnum.name.name] as String;
  }

  String? id;
  String? name;
}
