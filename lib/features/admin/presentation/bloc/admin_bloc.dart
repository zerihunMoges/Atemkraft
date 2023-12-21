import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../core/utils/usecases.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/fetch_clients.dart';

part 'admin_bloc_events.dart';
part 'admin_bloc_states.dart';

class AdminBloc extends Bloc<AdminEvent, AdminBlocState> {
  FetchClientsUseCase fetchClientUseCase;

  AdminBloc(this.fetchClientUseCase) : super(AdminBlocInitial()) {
    on<FetchClientsEvent>(_onFetchClients);
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
}
