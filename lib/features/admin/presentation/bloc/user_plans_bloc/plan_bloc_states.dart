part of 'plan_bloc.dart';

abstract class PlanBlocState extends Equatable {
  const PlanBlocState();

  @override
  List<Object> get props => [];
}

class PlanBlocInitial extends PlanBlocState {}

class FetchUserPlansLoading extends PlanBlocState {}

class FetchUserPlansSuccess extends PlanBlocState {
  final List<PlanEntity> plans;
  const FetchUserPlansSuccess(this.plans);
}

class FetchUserPlansFailure extends PlanBlocState {
  final String errorMessage;
  const FetchUserPlansFailure({required this.errorMessage});
}

class CreatePlanLoading extends PlanBlocState {}

class CreatePlanSuccess extends PlanBlocState {}

class CreatePlanFailure extends PlanBlocState {
  final String errorMessage;

  const CreatePlanFailure({required this.errorMessage});
}
