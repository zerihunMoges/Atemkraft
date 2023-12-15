import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseAuth get authInstance => _auth;
FirebaseFirestore get firestoreInstance => _firestore;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

String getDisplayName() {
  return FirebaseAuth.instance.currentUser?.displayName ?? 'There';
}

String getUserEmail() {
  return FirebaseAuth.instance.currentUser?.email ?? '';
}

String getUserId() {
  return FirebaseAuth.instance.currentUser!.uid;
}

Future<bool> isUserAdmin() async {
  final DocumentReference documentReference = FirebaseFirestore.instance
      .collection('role')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final DocumentSnapshot documentSnapshot = await documentReference.get();

  if (documentSnapshot.exists) {
    final Map data = documentSnapshot.data() as Map;
    final isAdmin = data['isAdmin'];
    return isAdmin;
  } else {
    return false;
  }
}

Future<void> signOutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Successfully logged out
  } catch (e) {
    // Handle logout failure
  }
}

Future<List<BoltPayload>> getBoltsFromCollection(String userId) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Bolt')
        .where('user', isEqualTo: userId)
        .get();

    List<BoltPayload> bolts = querySnapshot.docs
        .map((DocumentSnapshot doc) =>
            BoltPayload.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return bolts;
  } catch (e) {
    // Handle error if data retrieval fails
    print('Error retrieving data from Bolt collection: $e');
    return [];
  }
}
