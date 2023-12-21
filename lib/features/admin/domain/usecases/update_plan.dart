import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../repositories/admin_repository.dart';

class UpdatePlanUseCase implements UseCase<bool, List<String>> {
  final AdminRepository adminRepository;
  UpdatePlanUseCase(this.adminRepository);

  @override
  Future<Either<Failure, bool>> call(List<dynamic> params) async {
    final Either<Failure, bool> res =
        await adminRepository.updatePlan(params[0], params[1], params[2]);
    return res;
  }
}
