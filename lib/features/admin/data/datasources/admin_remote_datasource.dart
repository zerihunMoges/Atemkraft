import 'package:atemkraft/core/utils/firebase.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/client_entity_model.dart';
import '../models/plan_entity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminRemoteDataSource {
  Future<bool> createPlan(String uId, String description);
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
      final plans = snapshot.docs
          .map((doc) => PlanModel(
                uId: doc['uId'],
                planDescription: doc['planDescription'],
              ))
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
      // Handle errors accordingly
      return [];
    }
  }

  @override
  Future<List<ClientModel>> fetchClients() async {
    final snapshot = await _firestore.collection('userProfile').get();
    final clients = snapshot.docs
        .map((doc) => ClientModel(
              uId: doc.id,
              email: doc['email'],
            ))
        .toList();
    return clients;
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
}
