import 'package:caishen_wallet/models/category_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<List<CategoryModel>> categories() {
    try {
      return _firestore
          .collection('users')
          .doc(_uid)
          .collection('categories')
          .orderBy(CategoryEnum.name.name, descending: false)
          .snapshots()
          .map((query) {
        final retval = <CategoryModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          retval.add(
            CategoryModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return retval;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> newUser() async {
    final categories = [
      tr(LocaleTr.categoryFoodDrinks),
      tr(LocaleTr.categoryShopping),
      tr(LocaleTr.categoryTransport),
      tr(LocaleTr.categoryHealthFitness),
      tr(LocaleTr.categoryPersonalCare),
      tr(LocaleTr.categoryHouse),
      tr(LocaleTr.categoryInvestment),
      tr(LocaleTr.categoryVehicle),
      tr(LocaleTr.categoryEducation),
      tr(LocaleTr.categoryOther),
    ];

    for (final category in categories) {
      try {
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('categories')
            .add(<String, dynamic>{
          CategoryEnum.name.name: category,
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> add(String category) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('categories')
          .add(<String, dynamic>{
        CategoryEnum.name.name: category,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(CategoryModel category) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('categories')
          .doc(category.id)
          .update({
        CategoryEnum.name.name: category.name,
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
          .collection('categories')
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
