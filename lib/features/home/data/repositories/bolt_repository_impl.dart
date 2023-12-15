import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/network/network_info.dart';
import 'package:atemkraft/features/home/data/datasources/bolt_remote_datasource.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/domain/repositories/bolt_repository.dart';
import 'package:dartz/dartz.dart';

class BoltRepositoryImpl implements BoltRepository {
  final BoltRemoteDataSource boltRemoteDataSource;
  final NetworkInfo networkInfo;

  BoltRepositoryImpl({
    required this.networkInfo,
    required this.boltRemoteDataSource,
  });

  @override
  Future<Either<Failure, BoltPayload>> addBolt(BoltPayload bolt) async {
    if (await networkInfo.isConnected) {
      try {
        await boltRemoteDataSource.addBolt(bolt);
        return Right(bolt);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot register bolt, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, List<BoltPayload>>> getBolts(String user) async {
    if (await networkInfo.isConnected) {
      try {
        final bolts = await boltRemoteDataSource.getBolts(user);
        return Right(bolts);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot register bolt, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }
}
