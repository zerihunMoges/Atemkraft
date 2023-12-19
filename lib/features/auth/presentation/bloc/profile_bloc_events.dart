import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileBlocEvents extends Equatable {
  const ProfileBlocEvents();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileBlocEvents {
  final String? user;

  const GetProfileEvent({this.user});
}

class EditProfileEvent extends ProfileBlocEvents {
  final ProfilePayload profilePayload;
  const EditProfileEvent({required this.profilePayload});
}
