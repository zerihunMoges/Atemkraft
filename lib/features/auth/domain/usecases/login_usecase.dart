import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../entity/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<UserCredential, AuthPayload> {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(AuthPayload params) async {
    final Either<Failure, UserCredential> loginResponse =
        await authRepository.login(params);
    return loginResponse;
  }
}
