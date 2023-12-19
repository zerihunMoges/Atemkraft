part of 'plan_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class FetchUserPlansEvent extends AdminEvent {
  final String uId;

  const FetchUserPlansEvent({
    required this.uId,
  });
}

class CreatePlanEvent extends AdminEvent {
  final String description;
  final String uId;

  const CreatePlanEvent({required this.description, required this.uId});
}
