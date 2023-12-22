import '../../domain/entity/plan_entity.dart';

class PlanModel extends PlanEntity {
  PlanModel(
      {super.id,
      required super.uId,
      required super.planDescription,
      required super.completed});
}
