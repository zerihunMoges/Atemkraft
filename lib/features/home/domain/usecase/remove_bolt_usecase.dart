import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/utils/usecases.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/domain/repositories/bolt_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveBoltUsecase implements UseCase<void, String> {
  final BoltRepository boltRepository;
  RemoveBoltUsecase(this.boltRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final Either<Failure, void> getBoltsResponse =
        await boltRepository.removeBolt(params);
    return getBoltsResponse;
  }
}
