import 'package:caishen_wallet/models/category_model.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/services/firestore.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryController {
  final String _uid = Auth.auth.currentUser!.uid;

  Stream<List<CategoryModel>> categories() {
    try {
      return Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.categories.name)
          .orderBy(FsDocCategory.name.name, descending: false)
          .snapshots()
          .map((query) {
        final categories = <CategoryModel>[];

        for (final DocumentSnapshot doc in query.docs) {
          categories.add(
            CategoryModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }

        return categories;
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
        await Firestore.instance
            .collection(FsCollection.users.name)
            .doc(_uid)
            .collection(FsCollection.categories.name)
            .add(<String, dynamic>{
          FsDocCategory.name.name: category,
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> add(String category) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.categories.name)
          .add(<String, dynamic>{
        FsDocCategory.name.name: category,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(CategoryModel category) async {
    try {
      await Firestore.instance
          .collection(FsCollection.users.name)
          .doc(_uid)
          .collection(FsCollection.categories.name)
          .doc(category.id)
          .update({
        FsDocCategory.name.name: category.name,
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
          .collection(FsCollection.categories.name)
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
