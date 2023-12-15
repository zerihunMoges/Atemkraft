import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/core/utils/usecases.dart';
import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:atemkraft/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EditProfileUseCase implements UseCase<bool, ProfilePayload> {
  final AuthRepository authRepository;
  EditProfileUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(ProfilePayload profilePayload) async {
    final Either<Failure, bool> editProfileResponse =
        await authRepository.editProfile(profilePayload);
    return editProfileResponse;
  }
}
