import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/utils/usecases.dart';
import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:atemkraft/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase implements UseCase<ProfilePayload, String?> {
  final AuthRepository authRepository;
  GetProfileUseCase(this.authRepository);

  @override
  Future<Either<Failure, ProfilePayload>> call(String? user) async {
    final Either<Failure, ProfilePayload> getProfileResponse =
        await authRepository.getProfile(user);
    return getProfileResponse;
  }
}
