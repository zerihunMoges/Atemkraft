import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../entity/user_entity.dart';
import '../repositories/admin_repository.dart';

class FetchClientsUseCase implements UseCase<List<ClientEntity>, NoParams> {
  final AdminRepository adminRepository;
  FetchClientsUseCase(this.adminRepository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(NoParams params) async {
    final Either<Failure, List<ClientEntity>> fetchResult =
        await adminRepository.fetchClients();
    return fetchResult;
  }
}
