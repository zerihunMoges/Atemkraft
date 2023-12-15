import 'package:cloud_firestore/cloud_firestore.dart';
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
  final firestoreInstance = FirebaseFirestore.instance;

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
      firestoreInstance
          .collection('role')
          .doc(userCredential.user!.uid)
          .set({'isAdmin': false, 'uId': userCredential.user!.uid});

      await firestoreInstance
          .collection('userProfile')
          .doc(userCredential.user!.uid)
          .set({
        'dataOfBirth': '',
        'email': payload.email,
        'fullName': payload.fullName,
        'height': 0,
        'phoneNumber': '',
        'uId': userCredential.user!.uid,
        'weight': 0,
      });

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
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await _firebaseAuth.signOut();
        throw FirebaseAuthException(
            code: 'user-not-verified', message: 'Please verify your email');
      }
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
