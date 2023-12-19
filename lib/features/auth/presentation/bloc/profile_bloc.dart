import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:atemkraft/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:atemkraft/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_events.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileBlocEvents, ProfileBlocStates> {
  EditProfileUseCase editProfileUseCase;
  GetProfileUseCase getProfileUseCase;

  ProfileBloc(this.editProfileUseCase, this.getProfileUseCase)
      : super(ProfileBlocInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<EditProfileEvent>(_onEditProfile);
  }
  _onGetProfile(GetProfileEvent event, Emitter<ProfileBlocStates> emit) async {
    emit(GetProfileLoading());

    Either<Failure, ProfilePayload> response =
        await getProfileUseCase(event.user);

    response.fold(
        (Failure failure) =>
            emit(GetProfileFailure(errorMessage: failure.errorMessage)),
        (ProfilePayload success) =>
            emit(GetProfileSuccess(profilePayload: success)));
  }

  _onEditProfile(
      EditProfileEvent event, Emitter<ProfileBlocStates> emit) async {
    emit(EditProfileLoading());

    Either<Failure, bool> response =
        await editProfileUseCase(event.profilePayload);

    response.fold(
        (Failure failure) =>
            emit(EditProfileFailure(errorMessage: failure.errorMessage)),
        (success) => emit(EditProfileSuccess()));
  }
}
