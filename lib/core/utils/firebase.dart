import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


String getDisplayName() {
  return FirebaseAuth.instance.currentUser!.displayName ?? 'There';
}

Future<void> addToBoltTable(int duration) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      DateTime now = DateTime.now();

      await _firestore.collection('Bolt').add({
        'user': user.uid,
        'timestamp': now,
        'duration': duration,
      });
      // Data added successfully
    } else {
      // User is not signed in
    }
  } catch (e) {
    // Handle error if data addition fails
    print('Error adding data to Bolt collection: $e');
  }
}
