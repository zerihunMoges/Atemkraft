import 'package:atemkraft/core/errors/failures.dart';

import 'package:atemkraft/features/auth/domain/entity/user_entity.dart';

import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.resetPassword(email);
        return const Right(true);
      } catch (e) {
        return const Left(
            ServerFailure('Cannot reset password, Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(AuthPayload credentials) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDataSource.login(credentials);
        return Right(response);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          return const Left(
              ServerFailure('Invalid email or password. Please try again!'));
        } else {
          return Left(ServerFailure('Failed to login. Error: ${e.message}'));
        }
      } catch (e) {
        return const Left(
            ServerFailure('Failed to get a response. Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(
      AuthPayload credentials) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDataSource.signUp(credentials);
        return Right(response);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          return const Left(ServerFailure(
              'The email address is already in use. Please use a different email.'));
        } else {
          return Left(ServerFailure('Failed to sign up. Error: ${e.message}'));
        }
      } catch (e) {
        return const Left(
            ServerFailure('Failed to get a response. Please try again!'));
      }
    } else {
      return const Left(NetworkFailure(
          'No internet connection. Please check your connection and try again!'));
    }
  }
}
