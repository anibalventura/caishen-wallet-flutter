import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<String> createAccount(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> deleteAccount() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();
      }
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> signOut() async {
    try {
      await auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }
}
