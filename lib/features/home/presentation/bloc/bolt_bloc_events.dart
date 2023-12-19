import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BoltBlocEvents extends Equatable {
  const BoltBlocEvents();

  @override
  List<Object> get props => [];
}

class AddBoltEvent extends BoltBlocEvents {
  final BoltPayload payload;

  const AddBoltEvent({required this.payload});
}

class RemoveBoltEvent extends BoltBlocEvents {
  final String boltId;

  const RemoveBoltEvent({required this.boltId});
}

class GetBoltsEvent extends BoltBlocEvents {
  final String user;

  const GetBoltsEvent({required this.user});
}
