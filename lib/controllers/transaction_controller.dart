import 'package:caishen_wallet/models/transaction_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TransactionController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  String _payment = tr(LocaleTr.paymentCash);
  String get payment => _payment;
  set payment(String newValue) {
    _payment = newValue;
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
    _payment = tr(LocaleTr.paymentCash);
    _category = tr(LocaleTr.categoryFoodDrinks);
    _dateAndTime = DateTime.now();
    _description = '';
    notifyListeners();
  }

  Stream<List<TransactionModel>> transactions() {
    try {
      return _firestore
          .collection('transactions')
          .doc(_uid)
          .collection('transactions')
          .snapshots()
          .map((query) {
        final retval = <TransactionModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          retval.add(
            TransactionModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return retval;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> add() async {
    try {
      if (_amount != 0 && _description.isNotEmpty) {
        await _firestore
            .collection('transactions')
            .doc(_uid)
            .collection('transactions')
            .add(<String, dynamic>{
          TransactionEnum.type.name: _type,
          TransactionEnum.amount.name: _amount,
          TransactionEnum.payment.name: _payment,
          TransactionEnum.category.name: _category,
          TransactionEnum.dateAndTime.name: _dateAndTime.millisecondsSinceEpoch,
          TransactionEnum.description.name: _description,
        });

        _resetValues();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update({
    required String uid,
    required TransactionModel transaction,
  }) async {
    try {
      await _firestore
          .collection('transactions')
          .doc(_uid)
          .collection('transactions')
          .doc(transaction.id)
          .update({
        TransactionEnum.type.name: transaction.type,
        TransactionEnum.amount.name: transaction.amount,
        TransactionEnum.payment.name: transaction.payment,
        TransactionEnum.category.name: transaction.category,
        TransactionEnum.dateAndTime.name: transaction.dateAndTime,
        TransactionEnum.description.name: transaction.description,
      });

      _resetValues();
    } catch (e) {
      rethrow;
    }
  }
}
