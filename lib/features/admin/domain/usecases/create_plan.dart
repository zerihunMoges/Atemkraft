import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../repositories/admin_repository.dart';

class CreatePlanUseCase implements UseCase<bool, List<String>> {
  final AdminRepository adminRepository;
  CreatePlanUseCase(this.adminRepository);

  @override
  Future<Either<Failure, bool>> call(List<String> params) async {
    final Either<Failure, bool> res =
        await adminRepository.createPlan(params[0],params[1]);
    return res;
  }
}
