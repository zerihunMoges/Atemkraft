import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../../domain/entity/plan_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/create_plan.dart';
import '../../domain/usecases/fetch_clients.dart';
import '../../domain/usecases/fetch_user_plans.dart';

part 'admin_bloc_events.dart';
part 'admin_bloc_states.dart';

class AdminBloc extends Bloc<AdminEvent, AdminBlocState> {
  FetchClientsUseCase fetchClientUseCase;
  FetchUserPlansUseCase fetchUserPlansUseCase;
  CreatePlanUseCase createPlanUseCase;

  AdminBloc(this.fetchClientUseCase, this.fetchUserPlansUseCase,
      this.createPlanUseCase)
      : super(AdminBlocInitial()) {
    on<FetchClientsEvent>(_onFetchClients);
    on<FetchUserPlansEvent>(_onFetchUserPlans);
    on<CreatePlanEvent>(_onCreatePlan);
  }
  _onFetchClients(FetchClientsEvent event, Emitter<AdminBlocState> emit) async {
    emit(FetchClientsLoading());

    Either<Failure, List<ClientEntity>> response =
        await fetchClientUseCase(NoParams());

    response.fold(
        (Failure failure) =>
            emit(FetchClientsFailure(errorMessage: failure.errorMessage)),
        (List<ClientEntity> success) => emit(FetchClientsSuccess(success)));
  }

  _onFetchUserPlans(
      FetchUserPlansEvent event, Emitter<AdminBlocState> emit) async {
    emit(FetchUserPlansLoading());

    Either<Failure, List<PlanEntity>> response =
        await fetchUserPlansUseCase(event.uId);

    response.fold(
        (Failure failure) =>
            emit(FetchUserPlansFailure(errorMessage: failure.errorMessage)),
        (List<PlanEntity> success) => emit(FetchUserPlansSuccess(success)));
  }

  _onCreatePlan(CreatePlanEvent event, Emitter<AdminBlocState> emit) async {
    emit(CreatePlanLoading());

    Either<Failure, bool> response = await createPlanUseCase([event.uId,event.description]);

    response.fold(
        (Failure failure) =>
            emit(CreatePlanFailure(errorMessage: failure.errorMessage)),
        (bool success) => emit(CreatePlanSuccess()));
  }
}
