import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> login(AuthPayload credentials);

  Future<Either<Failure, UserCredential>> signUp(AuthPayload credentials);
  Future<Either<Failure, ProfilePayload>> getProfile(String? user);
  Future<Either<Failure, bool>> editProfile(ProfilePayload profilePayload);

  Future<Either<Failure, bool>> forgotPassword(String email);
}
