import 'package:atemkraft/features/admin/domain/usecases/delete_plan.dart';
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
  DeletePlanUseCase deletePlanUseCase;

  AdminBloc(this.fetchClientUseCase, this.deletePlanUseCase)
      : super(AdminBlocInitial()) {
    on<FetchClientsEvent>(_onFetchClients);
    on<DeletePlanEvent>(_onDeletePlan);
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

  _onDeletePlan(DeletePlanEvent event, Emitter<AdminBlocState> emit) async {
    emit(DeletePlanLoading());

    Either<Failure, bool> response = await deletePlanUseCase(event.id);

    response.fold(
        (Failure failure) =>
            emit(DeletePlanFailure(errorMessage: failure.errorMessage)),
        (bool success) => emit(DeletePlanSuccess()));
  }
}
