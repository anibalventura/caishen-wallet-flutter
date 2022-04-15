import 'package:caishen_wallet/models/payment_type_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentTypeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<List<PaymentTypeModel>> paymentTypes() {
    try {
      return _firestore
          .collection('users')
          .doc(_uid)
          .collection('payment_types')
          .orderBy(PaymentTypeEnum.name.name, descending: false)
          .snapshots()
          .map((query) {
        final retval = <PaymentTypeModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          retval.add(
            PaymentTypeModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return retval;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> newUser() async {
    final paymentTypes = [
      tr(LocaleTr.paymentCash),
      tr(LocaleTr.paymentCreditCard),
      tr(LocaleTr.paymentDebitCard),
      tr(LocaleTr.paymentBankTransfer),
      tr(LocaleTr.paymentOther),
    ];

    for (final paymentType in paymentTypes) {
      try {
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('payment_types')
            .add(<String, dynamic>{
          PaymentTypeEnum.name.name: paymentType,
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> add(String paymentType) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('payment_types')
          .add(<String, dynamic>{
        PaymentTypeEnum.name.name: paymentType,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(PaymentTypeModel paymentType) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('payment_types')
          .doc(paymentType.id)
          .update({
        PaymentTypeEnum.name.name: paymentType.name,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete({
    required String docId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('payment_types')
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
