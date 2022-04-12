import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionEnum {
  type,
  amount,
  paymentType,
  category,
  dateAndTime,
  description,
}

class TransactionModel {
  TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    required this.paymentType,
    required this.category,
    required this.dateAndTime,
    required this.description,
  });

  TransactionModel.fromDocumentSnapshot({
    required DocumentSnapshot documentSnapshot,
  }) {
    id = documentSnapshot.id;
    type = documentSnapshot[TransactionEnum.type.name] as int;
    amount = documentSnapshot[TransactionEnum.amount.name] as double;
    paymentType = documentSnapshot[TransactionEnum.paymentType.name] as String;
    category = documentSnapshot[TransactionEnum.category.name] as String;
    dateAndTime = documentSnapshot[TransactionEnum.dateAndTime.name] as int;
    description = documentSnapshot[TransactionEnum.description.name] as String;
  }

  String? id;
  int? type;
  double? amount;
  String? paymentType;
  String? category;
  int? dateAndTime;
  String? description;
}
