import 'package:cloud_firestore/cloud_firestore.dart';

enum CategoryEnum {
  name,
}

class CategoryModel {
  CategoryModel({
    this.id,
    required this.name,
  });

  CategoryModel.fromDocumentSnapshot({
    required DocumentSnapshot documentSnapshot,
  }) {
    id = documentSnapshot.id;
    name = documentSnapshot[CategoryEnum.name.name] as String;
  }

  String? id;
  String? name;
}
