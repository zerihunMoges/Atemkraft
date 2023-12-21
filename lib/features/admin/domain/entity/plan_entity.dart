class PlanEntity {
  final String uId;
  final String planDescription;
  final bool completed;

  PlanEntity(
      {required this.uId,
      required this.planDescription,
      this.completed = false});
}
