import 'package:atemkraft/core/utils/firebase.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/client_entity_model.dart';
import '../models/plan_entity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminRemoteDataSource {
  Future<bool> createPlan(String uId, String description);
  Future<bool> updatePlan(String id, String description, bool compeleted);
  Future<bool> deletePlan(String id);
  Future<List<PlanModel>> fetchUserPlans(String uId);

  Future<List<ClientModel>> fetchClients();
}

class AdminDataSourceImpl implements AdminRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AdminDataSourceImpl();

  @override
  Future<bool> createPlan(String uId, description) async {
    try {
      await _firestore.collection('plans').add({
        'uId': uId,
        'planDescription': description,
        'completed': false,
        'createdDate': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PlanModel>> fetchUserPlans(String uId) async {
    try {
      final snapshot = await _firestore
          .collection('plans')
          .where('uId', isEqualTo: uId)
          .get();

      var docs = snapshot.docs;

      docs.sort((a, b) {
        var aDate = a.get('createdDate').toDate();
        var bDate = b.get('createdDate').toDate();
        return bDate.compareTo(aDate);
      });
      final plans = docs
          .map((doc) => PlanModel(
              id: doc.id,
              uId: doc['uId'],
              planDescription: doc['planDescription'],
              completed: doc['completed']))
          .toList();

      return plans;
      // final snapshot = await _firestore.collection('plans').where('uId', (v) => v == uId;).get();
      // final plans = snapshot.docs
      //     .map((doc) => PlanModel(
      //           uId: doc.id,
      //           planDescription: doc['planDescription'],
      //         ))
      //     .toList();
      // return plans;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ClientModel>> fetchClients() async {
    try {
      final snapshot = await _firestore.collection('userProfile').get();
      final clients = snapshot.docs
          .map((doc) => ClientModel(
                uId: doc.id,
                name: 'He',
                email: doc['email'],
              ))
          .toList();
      return clients;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deletePlan(String id) async {
    try {
      await firestoreInstance.collection('plans').doc(id).delete();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updatePlan(
      String id, String description, bool compeleted) async {
    try {
      await _firestore
          .collection('plans')
          .doc(id)
          .update({'planDescription': description, 'completed': compeleted});

      return true;
    } catch (e) {
      throw ServerException();
    }
  }
}
