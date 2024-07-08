import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/models/Success.dart';
import 'package:dalak_blog_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthController {
  static Future<Either<ErrorMessage, SuccessMessage>> signupUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final res = await db
          .collection("users")
          .where("username", isEqualTo: username)
          .get();

      if (res.docs.isNotEmpty) {
        await userCredential.user!.delete();
        return left(ErrorMessage(body: "Username already in use."));
      }

      await db.collection("users").doc(userCredential.user!.uid).set({
        "username": username,
        "email": userCredential.user!.email,
      });

      return right(SuccessMessage(body: "User created successfully!"));
    } on FirebaseAuthException catch (_) {
      return left(ErrorMessage(body: "Email already in use."));
    } on FirebaseException catch (e) {
      await auth.currentUser!.delete();
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      await auth.currentUser!.delete();
      return left(ErrorMessage(body: e.toString()));
    }
  }

  static Future<Either<ErrorMessage, SuccessMessage>> loginUser({
    required String emailUsername,
    required String password,
  }) async {
    try {
      if (emailRegex.hasMatch(emailUsername)) {
        await auth.signInWithEmailAndPassword(
          email: emailUsername,
          password: password,
        );
      } else {
        final res = await db
            .collection("users")
            .where("username", isEqualTo: emailUsername)
            .get();
        if (res.docs.isEmpty) {
          return left(ErrorMessage(body: "Incorrect email or password."));
        }
        final email = res.docs.first.data()['email'];
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      return right(SuccessMessage(body: "Logged in successfully!"));
    } on FirebaseAuthException catch (_) {
      return left(ErrorMessage(body: "Incorrect email or password."));
    } on FirebaseException catch (_) {
      return left(ErrorMessage(body: "Unable to fetch user data"));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }
}
