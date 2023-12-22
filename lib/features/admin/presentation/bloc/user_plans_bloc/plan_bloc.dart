import 'package:atemkraft/features/admin/domain/usecases/delete_plan.dart';
import 'package:atemkraft/features/admin/domain/usecases/update_plan.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entity/plan_entity.dart';
import '../../../domain/usecases/create_plan.dart';
import '../../../domain/usecases/fetch_user_plans.dart';

part 'plan_bloc_events.dart';
part 'plan_bloc_states.dart';

class PlanBloc extends Bloc<PlanEvent, PlanBlocState> {
  FetchUserPlansUseCase fetchUserPlansUseCase;
  CreatePlanUseCase createPlanUseCase;
  DeletePlanUseCase deletePlanUseCase;
  UpdatePlanUseCase updatePlanUseCase;

  PlanBloc(this.fetchUserPlansUseCase, this.createPlanUseCase,
      this.deletePlanUseCase, this.updatePlanUseCase)
      : super(PlanBlocInitial()) {
    on<FetchUserPlansEvent>(_onFetchUserPlans);
    on<CreatePlanEvent>(_onCreatePlan);
    on<DeletePlanEvent>(_onDeletePlan);
    on<UpdatePlanEvent>(_onUpdatePlan);
  }

  _onFetchUserPlans(
      FetchUserPlansEvent event, Emitter<PlanBlocState> emit) async {
    emit(FetchUserPlansLoading());

    Either<Failure, List<PlanEntity>> response =
        await fetchUserPlansUseCase(event.uId);

    response.fold(
        (Failure failure) =>
            emit(FetchUserPlansFailure(errorMessage: failure.errorMessage)),
        (List<PlanEntity> success) => emit(FetchUserPlansSuccess(success)));
  }

  _onCreatePlan(CreatePlanEvent event, Emitter<PlanBlocState> emit) async {
    emit(CreatePlanLoading());

    Either<Failure, bool> response =
        await createPlanUseCase([event.uId, event.description]);

    response.fold(
        (Failure failure) =>
            emit(CreatePlanFailure(errorMessage: failure.errorMessage)),
        (bool success) => emit(CreatePlanSuccess()));
  }

  _onDeletePlan(DeletePlanEvent event, Emitter<PlanBlocState> emit) async {
    emit(DeletePlanLoading());

    Either<Failure, bool> response = await deletePlanUseCase(event.id);

    response.fold(
        (Failure failure) =>
            emit(DeletePlanFailure(errorMessage: failure.errorMessage)),
        (bool success) => emit(DeletePlanSuccess()));
  }

  _onUpdatePlan(UpdatePlanEvent event, Emitter<PlanBlocState> emit) async {
    emit(UpdatePlanLoading());

    Either<Failure, bool> response = await updatePlanUseCase(
        [event.id, event.description, event.compeleted]);

    response.fold(
        (Failure failure) =>
            emit(UpdatePlanFailure(errorMessage: failure.errorMessage)),
        (bool success) => emit(UpdatePlanSuccess()));
  }
}
