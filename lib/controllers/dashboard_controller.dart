import 'package:caishen_wallet/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<double> expenses() {
    try {
      return _firestore
          .collection('users')
          .doc(_uid)
          .collection('transactions')
          .where('type', isEqualTo: 0)
          .snapshots()
          .map((query) {
        var expenses = 0.0;

        for (final DocumentSnapshot doc in query.docs) {
          if (DateTime.now().month ==
              DateTime.fromMillisecondsSinceEpoch(doc['dateAndTime'] as int)
                  .month) {
            expenses += doc['amount'] as double;
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
      return _firestore
          .collection('users')
          .doc(_uid)
          .collection('transactions')
          .where('type', isEqualTo: 1)
          .snapshots()
          .map((query) {
        var incomes = 0.0;

        for (final DocumentSnapshot doc in query.docs) {
          if (DateTime.now().month ==
              DateTime.fromMillisecondsSinceEpoch(doc['dateAndTime'] as int)
                  .month) {
            incomes += doc['amount'] as double;
          }
        }

        return incomes;
      });
    } catch (e) {
      rethrow;
    }
  }
}
