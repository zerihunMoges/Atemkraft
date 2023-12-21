part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class FetchClientsEvent extends AdminEvent {}

class DeletePlanEvent extends AdminEvent {
  final String id;

  DeletePlanEvent({required this.id});
}
