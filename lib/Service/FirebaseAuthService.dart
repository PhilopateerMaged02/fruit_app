import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_app/Failures/exceptions.dart';

class Firebaseauthservice {
  Future<User> createUser(
      {required String email, required String Password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: "the password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(
            message: "the account arleady exist for that email");
      } else {
        throw CustomExceptions(
            message: "an error occured. please try again later");
      }
    } catch (e) {
      throw CustomExceptions(
          message: "an error occured. please try again later");
    }
  }
}
