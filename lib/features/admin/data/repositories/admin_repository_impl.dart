import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/features/admin/domain/entity/plan_entity.dart';
import 'package:atemkraft/features/admin/domain/entity/user_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_datasource.dart';
import '../models/client_entity_model.dart';
import '../models/plan_entity_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;
  final NetworkInfo networkInfo;

  AdminRepositoryImpl({
    required this.networkInfo,
    required this.adminRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createPlan(
      String uId, String description) async {
    if (await networkInfo.isConnected) {
      try {
        bool res = await adminRemoteDataSource.createPlan(uId, description);
        return Right(res);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot create plan, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> fetchClients() async {
    if (await networkInfo.isConnected) {
      try {
        List<ClientModel> clients = await adminRemoteDataSource.fetchClients();
        return Right(clients);
      } catch (e) {
        print(e);
        return const Left(
            ServerFailure('Cannot fetch clients, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, List<PlanEntity>>> fetchUserPlans(String uId) async {
    if (await networkInfo.isConnected) {
      try {
        List<PlanModel> plans = await adminRemoteDataSource.fetchUserPlans(uId);
        return Right(plans);
      } catch (e) {
        print(e.toString());
        return const Left(
            ServerFailure('Cannot fetch plans, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePlan(String id) async {
    if (await networkInfo.isConnected) {
      try {
        bool res = await adminRemoteDataSource.deletePlan(id);
        return Right(res);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot delete plan, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePlan(
      String id, String description, bool compeleted) async {
    if (await networkInfo.isConnected) {
      try {
        bool res =
            await adminRemoteDataSource.updatePlan(id, description, compeleted);
        return Right(res);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot update plan, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePlan(String id) async {
    if (await networkInfo.isConnected) {
      try {
        bool res = await adminRemoteDataSource.deletePlan(id);
        return Right(res);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot delete plan, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }
}
