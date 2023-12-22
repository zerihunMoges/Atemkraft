part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class FetchUserPlansEvent extends PlanEvent {
  final String uId;

  const FetchUserPlansEvent({
    required this.uId,
  });
}

class CreatePlanEvent extends PlanEvent {
  final String description;
  final String uId;
  final bool compeleted;

  const CreatePlanEvent(
      {required this.description, required this.uId, this.compeleted = false});
}

class DeletePlanEvent extends PlanEvent {
  final String id;

  DeletePlanEvent({required this.id});
}

class UpdatePlanEvent extends PlanEvent {
  final String description;
  final String id;
  final bool compeleted;

  const UpdatePlanEvent(
      {required this.description, required this.id, required this.compeleted});
}
