import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp(
    AuthPayload payload,
  );

  Future<UserCredential> login(
    AuthPayload payload,
  );

  Future<void> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signUp(
    AuthPayload payload,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: payload.email, password: payload.password);

      // Update the user's display name with the provided full name
      await userCredential.user!.updateDisplayName(payload.fullName);
      await userCredential.user!.sendEmailVerification();

      return userCredential;
    } catch (e) {
      throw FirebaseAuthException(code: 'email-already-in-use');
    }
  }

  @override
  Future<UserCredential> login(
    AuthPayload payload,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: payload.email, password: payload.password);

      return userCredential;
    } catch (e) {
      throw FirebaseAuthException(code: 'user-not-found');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseAuthException(code: 'reset-faild');
    }
  }
}
