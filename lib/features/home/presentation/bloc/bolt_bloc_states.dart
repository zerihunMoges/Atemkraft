import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BoltBlocStates extends Equatable {
  const BoltBlocStates();

  @override
  List<Object> get props => [];
}

class BoltInitial extends BoltBlocStates {}

class AddBoltLoading extends BoltBlocStates {}

class AddBoltFailure extends BoltBlocStates {
  final String errorMessage;

  const AddBoltFailure({required this.errorMessage});
}

class AddBoltSuccess extends BoltBlocStates {}

class GetBoltsLoading extends BoltBlocStates {}

class GetBoltsSuccess extends BoltBlocStates {
  final List<BoltPayload> bolts;

  const GetBoltsSuccess({required this.bolts});
}

class GetBoltsFailure extends BoltBlocStates {
  final String errorMessage;

  const GetBoltsFailure({required this.errorMessage});
}

class RemoveBoltSuccess extends BoltBlocStates {}

class RemoveBoltLoading extends BoltBlocStates {}

class RemoveBoltFailure extends BoltBlocStates {
  final String errorMessage;

  const RemoveBoltFailure({required this.errorMessage});
}
