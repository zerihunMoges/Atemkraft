part of 'admin_bloc.dart';

abstract class AdminBlocState extends Equatable {
  const AdminBlocState();

  @override
  List<Object> get props => [];
}

class AdminBlocInitial extends AdminBlocState {}

class FetchClientsLoading extends AdminBlocState {}

class FetchClientsSuccess extends AdminBlocState {
  final List<ClientEntity> clients;
  const FetchClientsSuccess(this.clients);
}

class FetchClientsFailure extends AdminBlocState {
  final String errorMessage;
  const FetchClientsFailure({required this.errorMessage});
}

class FetchUserPlansLoading extends AdminBlocState {}

class FetchUserPlansSuccess extends AdminBlocState {
  final List<PlanEntity> plans;
  const FetchUserPlansSuccess(this.plans);
}

class FetchUserPlansFailure extends AdminBlocState {
  final String errorMessage;
  const FetchUserPlansFailure({required this.errorMessage});
}

class CreatePlanLoading extends AdminBlocState {}

class CreatePlanSuccess extends AdminBlocState {}

class CreatePlanFailure extends AdminBlocState {
  final String errorMessage;

  const CreatePlanFailure({required this.errorMessage});
}
