import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> login(AuthPayload credentials);

  Future<Either<Failure, UserCredential>> signUp(AuthPayload credentials);

  Future<Either<Failure, bool>> forgotPassword(String email);
}
