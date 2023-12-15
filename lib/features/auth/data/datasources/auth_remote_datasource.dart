import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
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

  Future<bool> editProfile(
    ProfilePayload payload,
  );

  Future<ProfilePayload> getProfile(String? user);

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

  @override
  Future<bool> editProfile(ProfilePayload payload) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference profileCollection =
            firestoreInstance.collection('userProfile');

        QuerySnapshot querySnapshot = await profileCollection
            .where('user', isEqualTo: user.uid)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          await profileCollection.doc(documentSnapshot.id).update({
            'name': payload.fullName,
            'dateOfBirth': payload.dateOfBirth,
            'size': payload.size,
            'phonenumber': payload.phonenumber,
            'weight': payload.weight
          });
          return true;
        } else {
          throw Exception('profile not found!');
        }
      } else {
        throw Exception('User not signed in.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProfilePayload> getProfile(String? userId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference profileCollection =
            firestoreInstance.collection('userProfile');

        QuerySnapshot querySnapshot = await profileCollection
            .where('user', isEqualTo: userId ?? user.uid)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          ProfilePayload profileData = ProfilePayload.fromMap(
              querySnapshot.docs.first.data() as Map<String, dynamic>,
              user.uid,
              user.email!,
              user.displayName!);

          return profileData;
        } else {
          throw Exception('profile not found');
        }
      } else {
        throw Exception('User not signed in.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
