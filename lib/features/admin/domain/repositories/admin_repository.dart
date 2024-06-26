import 'package:atemkraft/features/admin/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entity/plan_entity.dart';

abstract class AdminRepository {
  Future<Either<Failure, bool>> createPlan(String uId, String description);
  Future<Either<Failure, bool>> updatePlan(
      String uId, String description, bool compeleted);
  Future<Either<Failure, bool>> deletePlan(String id);
  Future<Either<Failure, List<PlanEntity>>> fetchUserPlans(String uId);

  Future<Either<Failure, List<ClientEntity>>> fetchClients();
}
