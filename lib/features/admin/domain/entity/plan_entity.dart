class PlanEntity {
  final String? id;
  final String uId;
  final String planDescription;
  final bool completed;

  PlanEntity(
      {required this.uId,
      this.id,
      required this.planDescription,
      this.completed = false});
}
