import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';

abstract class BoltRemoteDataSource {
  Future<void> addBolt(
    BoltPayload payload,
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
      await addToBoltTable(payload.duration);
    } catch (e) {}
  }

  @override
  Future<List<BoltPayload>> getBolts(
    String user,
  ) async {
    try {
      return await getBoltsFromCollection(user);
    } catch (e) {
      return [];
    }
  }
}
