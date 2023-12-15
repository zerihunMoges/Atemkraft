import 'package:atemkraft/features/admin/domain/entity/plan_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../repositories/admin_repository.dart';

class FetchUserPlansUseCase implements UseCase<List<PlanEntity>, String> {
  final AdminRepository adminRepository;
  FetchUserPlansUseCase(this.adminRepository);

  @override
  Future<Either<Failure, List<PlanEntity>>> call(String uId) async {
    final Either<Failure, List<PlanEntity>> fetchResult =
        await adminRepository.fetchUserPlans(uId);
    return fetchResult;
  }
}
