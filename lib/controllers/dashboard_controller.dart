import 'package:caishen_wallet/models/transaction_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController {
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<double> expenses() {
    try {
      return Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.transactions.name)
          .where(FsDocTransaction.type.name, isEqualTo: 0)
          .snapshots()
          .map((query) {
        var expenses = 0.0;

        for (final DocumentSnapshot doc in query.docs) {
          if (DateTime.now().month ==
              DateTime.fromMillisecondsSinceEpoch(
                doc[FsDocTransaction.dateAndTime.name] as int,
              ).month) {
            expenses += doc[FsDocTransaction.amount.name] as double;
          }
        }

        return expenses;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<double> incomes() {
    try {
      return Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.transactions.name)
          .where(FsDocTransaction.type.name, isEqualTo: 1)
          .snapshots()
          .map((query) {
        var incomes = 0.0;

        for (final DocumentSnapshot doc in query.docs) {
          if (DateTime.now().month ==
              DateTime.fromMillisecondsSinceEpoch(
                doc[FsDocTransaction.dateAndTime.name] as int,
              ).month) {
            incomes += doc[FsDocTransaction.amount.name] as double;
          }
        }

        return incomes;
      });
    } catch (e) {
      rethrow;
    }
  }
}
