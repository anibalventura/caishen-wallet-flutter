import 'package:cloud_firestore/cloud_firestore.dart';

enum FsCollection {
  users,
  transactions,
  paymentTypes,
  categories,
}

class Firestore {
  static final FirebaseFirestore instance = FirebaseFirestore.instance;
}
