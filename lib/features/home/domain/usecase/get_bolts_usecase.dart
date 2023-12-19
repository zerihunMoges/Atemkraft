import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/utils/usecases.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/domain/repositories/bolt_repository.dart';
import 'package:dartz/dartz.dart';

class GetBoltsUsecase implements UseCase<List<BoltPayload>, String> {
  final BoltRepository boltRepository;
  GetBoltsUsecase(this.boltRepository);

  @override
  Future<Either<Failure, List<BoltPayload>>> call(String params) async {
    final Either<Failure, List<BoltPayload>> getBoltsResponse =
        await boltRepository.getBolts(params);
    return getBoltsResponse;
  }
}
