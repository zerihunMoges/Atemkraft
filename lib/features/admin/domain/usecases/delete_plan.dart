import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../repositories/admin_repository.dart';

class DeletePlanUseCase implements UseCase<bool, String> {
  final AdminRepository adminRepository;
  DeletePlanUseCase(this.adminRepository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    final Either<Failure, bool> res = await adminRepository.deletePlan(params);
    return res;
  }
}
