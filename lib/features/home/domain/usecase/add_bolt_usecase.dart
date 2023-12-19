import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/utils/usecases.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/domain/repositories/bolt_repository.dart';
import 'package:dartz/dartz.dart';

class AddBoltUsecase implements UseCase<BoltPayload, BoltPayload> {
  final BoltRepository boltRepository;
  AddBoltUsecase(this.boltRepository);

  @override
  Future<Either<Failure, BoltPayload>> call(BoltPayload params) async {
    final Either<Failure, BoltPayload> addBOLTResponse =
        await boltRepository.addBolt(params);
    return addBOLTResponse;
  }
}
