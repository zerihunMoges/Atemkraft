import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileBlocStates extends Equatable {
  const ProfileBlocStates();

  @override
  List<Object> get props => [];
}

class ProfileBlocInitial extends ProfileBlocStates {}

class GetProfileLoading extends ProfileBlocStates {}

class GetProfileSuccess extends ProfileBlocStates {
  final ProfilePayload profilePayload;

  const GetProfileSuccess({required this.profilePayload});
}

class EditProfileLoading extends ProfileBlocStates {}

class EditProfileSuccess extends ProfileBlocStates {}

class EditProfileFailure extends ProfileBlocStates {
  final String errorMessage;

  const EditProfileFailure({required this.errorMessage});
}

class GetProfileFailure extends ProfileBlocStates {
  final String errorMessage;

  const GetProfileFailure({required this.errorMessage});
}
