import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BoltRemoteDataSource {
  Future<void> addBolt(
    BoltPayload payload,
  );
  Future<void> removeBolt(
    String id,
  );
  Future<List<BoltPayload>> getBolts(
    String user,
  );
}

class BoltRemoteDataSourceImpl implements BoltRemoteDataSource {
  @override
  Future<void> addBolt(
    BoltPayload payload,
  ) async {
    try {
      User? user = authInstance.currentUser;
      if (user != null) {
        DateTime now = DateTime.now();

        await firestoreInstance.collection('Bolt').add({
          'user': user.uid,
          'timestamp': now,
          'duration': payload.duration,
        });
      } else {
        throw Exception('user not signed in');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BoltPayload>> getBolts(
    String user,
  ) async {
    try {
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection('Bolt')
          .where('user', isEqualTo: user)
          .get();

      List<BoltPayload> bolts = querySnapshot.docs
          .map((DocumentSnapshot doc) =>
              BoltPayload.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      return bolts;
    } catch (e) {
      throw Exception('Error retrieving data from Bolt collection: $e');
    }
  }

  @override
  Future<void> removeBolt(String id) async {
    try {
      User? user = authInstance.currentUser;
      if (user != null) {
        await firestoreInstance.collection('Bolt').doc(id).delete();
      } else {
        throw Exception('user not signed in');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
