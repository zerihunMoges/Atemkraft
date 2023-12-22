import 'package:atemkraft/core/errors/failures.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/domain/usecase/add_bolt_usecase.dart';
import 'package:atemkraft/features/home/domain/usecase/get_bolts_usecase.dart';
import 'package:atemkraft/features/home/domain/usecase/remove_bolt_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bolt_bloc_events.dart';
import 'bolt_bloc_states.dart';

class BoltBloc extends Bloc<BoltBlocEvents, BoltBlocStates> {
  AddBoltUsecase addBoltUsecase;
  GetBoltsUsecase getBoltsUsecase;
  RemoveBoltUsecase removeBoltUsecase;

  BoltBloc(this.addBoltUsecase, this.getBoltsUsecase, this.removeBoltUsecase)
      : super(BoltInitial()) {
    on<AddBoltEvent>(_onAddBolt);
    on<GetBoltsEvent>(_onGetBolts);
    on<RemoveBoltEvent>(_onRemoveBolt);
  }
  _onAddBolt(AddBoltEvent event, Emitter<BoltBlocStates> emit) async {
    emit(AddBoltLoading());

    Either<Failure, BoltPayload> response = await addBoltUsecase(event.payload);

    response.fold(
        (Failure failure) =>
            emit(AddBoltFailure(errorMessage: failure.errorMessage)),
        (BoltPayload success) => emit(AddBoltSuccess()));
  }

  _onGetBolts(GetBoltsEvent event, Emitter<BoltBlocStates> emit) async {
    emit(GetBoltsLoading());

    Either<Failure, List<BoltPayload>> response =
        await getBoltsUsecase(event.user);

    response.fold(
        (Failure failure) =>
            emit(GetBoltsFailure(errorMessage: failure.errorMessage)),
        (List<BoltPayload> success) => emit(GetBoltsSuccess(bolts: success)));
  }

  _onRemoveBolt(RemoveBoltEvent event, Emitter<BoltBlocStates> emit) async {
    emit(RemoveBoltLoading());

    Either<Failure, void> response = await removeBoltUsecase(event.boltId);

    response.fold(
        (Failure failure) =>
            emit(RemoveBoltFailure(errorMessage: failure.errorMessage)),
        (success) => emit(RemoveBoltSuccess()));
  }
}
