import 'package:caishen_wallet/controllers/category_controller.dart';
import 'package:caishen_wallet/controllers/payment_type_controller.dart';
import 'package:caishen_wallet/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get user => auth.authStateChanges();

  static Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changeUsername(String newUsername) async {
    try {
      if (auth.currentUser?.uid != null) {
        await auth.currentUser?.updateDisplayName(newUsername);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changeEmail(String newEmail) async {
    try {
      if (auth.currentUser?.uid != null) {
        await auth.currentUser?.updateEmail(newEmail);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changePassword(String newPassword) async {
    try {
      if (auth.currentUser?.uid != null) {
        await auth.currentUser?.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createAccount(
    String name,
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await auth.currentUser?.updateDisplayName(name);

      final categoryController = CategoryController();
      final paymentTypeController = PaymentTypeController();
      await categoryController.newUser();
      await paymentTypeController.newUser();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteAccount() async {
    try {
      if (auth.currentUser != null) {
        await Firestore.instance
            .collection(FsCollection.users.name)
            .doc(Auth.auth.currentUser!.uid)
            .delete();

        await auth.currentUser!.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }
}
