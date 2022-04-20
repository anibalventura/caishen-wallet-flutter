import 'package:caishen_wallet/models/transaction_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/services/firestore.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TransactionController extends ChangeNotifier {
  final String _uid = Auth.auth.currentUser!.uid;

  int _type = 0;
  int get type => _type;
  set type(int newValue) {
    _type = newValue;
    notifyListeners();
  }

  double _amount = 0;
  double get amount => _amount;
  set amount(double newValue) {
    _amount = newValue;
    notifyListeners();
  }

  String _paymentType = tr(LocaleTr.paymentCash);
  String get paymentType => _paymentType;
  set paymentType(String newValue) {
    _paymentType = newValue;
    notifyListeners();
  }

  String _category = tr(LocaleTr.categoryFoodDrinks);
  String get category => _category;
  set category(String newValue) {
    _category = newValue;
    notifyListeners();
  }

  DateTime _dateAndTime = DateTime.now();
  DateTime get dateAndTime => _dateAndTime;
  set dateAndTime(DateTime newValue) {
    _dateAndTime = newValue;
    notifyListeners();
  }

  String _description = '';
  String get description => _description;
  set description(String newValue) {
    _description = newValue;
    notifyListeners();
  }

  void _resetValues() {
    _type = 0;
    _amount = 0;
    _paymentType = tr(LocaleTr.paymentCash);
    _category = tr(LocaleTr.categoryFoodDrinks);
    _dateAndTime = DateTime.now();
    _description = '';
    notifyListeners();
  }

  Stream<List<TransactionModel>> transactions() {
    try {
      return Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.transactions.name)
          .orderBy(FsDocTransaction.dateAndTime.name, descending: true)
          .snapshots()
          .map((query) {
        final transactions = <TransactionModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          transactions.add(
            TransactionModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return transactions;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> add() async {
    try {
      if (_amount != 0 && _description.isNotEmpty) {
        await Firestore.instance
            .collection(FsCollection.users.name)
            .doc(_uid)
            .collection(FsCollection.transactions.name)
            .add(<String, dynamic>{
          FsDocTransaction.type.name: _type,
          FsDocTransaction.amount.name: _amount,
          FsDocTransaction.paymentType.name: _paymentType,
          FsDocTransaction.category.name: _category,
          FsDocTransaction.dateAndTime.name:
              _dateAndTime.millisecondsSinceEpoch,
          FsDocTransaction.description.name: _description,
        });

        _resetValues();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(TransactionModel transaction) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.transactions.name)
          .doc(transaction.id)
          .update({
        FsDocTransaction.type.name: transaction.type,
        FsDocTransaction.amount.name: transaction.amount,
        FsDocTransaction.paymentType.name: transaction.paymentType,
        FsDocTransaction.category.name: transaction.category,
        FsDocTransaction.dateAndTime.name: transaction.dateAndTime,
        FsDocTransaction.description.name: transaction.description,
      });

      _resetValues();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete({
    required String docId,
  }) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.transactions.name)
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
