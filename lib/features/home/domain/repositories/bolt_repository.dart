import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BoltRepository {
  Future<Either<Failure, BoltPayload>> addBolt(BoltPayload bolt);
  Future<Either<Failure, List<BoltPayload>>> getBolts(String user);
  Future<Either<Failure, void>> removeBolt(String id);
}
