import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<bool, String> {
  final AuthRepository authRepository;
  ForgotPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(String email) async {
    final Either<Failure, bool> loginResponse =
        await authRepository.forgotPassword(email);
    return loginResponse;
  }
}
