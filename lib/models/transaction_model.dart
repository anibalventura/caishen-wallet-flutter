import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionEnum {
  type,
  amount,
  payment,
  category,
  dateAndTime,
  description,
}

class TransactionModel {
  TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    required this.payment,
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
    payment = documentSnapshot[TransactionEnum.payment.name] as String;
    category = documentSnapshot[TransactionEnum.category.name] as String;
    dateAndTime = documentSnapshot[TransactionEnum.dateAndTime.name] as int;
    description = documentSnapshot[TransactionEnum.description.name] as String;
  }

  String? id;
  int? type;
  double? amount;
  String? payment;
  String? category;
  int? dateAndTime;
  String? description;
}
