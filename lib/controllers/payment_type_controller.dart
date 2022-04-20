import 'package:caishen_wallet/models/payment_type_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/services/firestore.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentTypeController {
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<List<PaymentTypeModel>> paymentTypes() {
    try {
      return Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.paymentTypes.name)
          .orderBy(FsDocPaymentType.name.name, descending: false)
          .snapshots()
          .map((query) {
        final paymentTypes = <PaymentTypeModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          paymentTypes.add(
            PaymentTypeModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return paymentTypes;
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
        await Firestore.instance
            .collection(FsCollection.users.name)
            .doc(_uid)
            .collection(FsCollection.paymentTypes.name)
            .add(<String, dynamic>{
          FsDocPaymentType.name.name: paymentType,
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> add(String paymentType) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.paymentTypes.name)
          .add(<String, dynamic>{
        FsDocPaymentType.name.name: paymentType,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(PaymentTypeModel paymentType) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.paymentTypes.name)
          .doc(paymentType.id)
          .update({
        FsDocPaymentType.name.name: paymentType.name,
      });
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
          .collection(FsCollection.paymentTypes.name)
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
