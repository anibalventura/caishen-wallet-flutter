import 'package:cloud_firestore/cloud_firestore.dart';

enum FsDocTransaction {
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
    type = documentSnapshot[FsDocTransaction.type.name] as int;
    amount = documentSnapshot[FsDocTransaction.amount.name] as double;
    paymentType = documentSnapshot[FsDocTransaction.paymentType.name] as String;
    category = documentSnapshot[FsDocTransaction.category.name] as String;
    dateAndTime = documentSnapshot[FsDocTransaction.dateAndTime.name] as int;
    description = documentSnapshot[FsDocTransaction.description.name] as String;
  }

  String? id;
  int? type;
  double? amount;
  String? paymentType;
  String? category;
  int? dateAndTime;
  String? description;
}
