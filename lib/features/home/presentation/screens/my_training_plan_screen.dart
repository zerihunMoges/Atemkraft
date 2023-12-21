import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/features/admin/domain/entity/plan_entity.dart';
import 'package:atemkraft/features/admin/presentation/bloc/user_plans_bloc/plan_bloc.dart';
import 'package:atemkraft/features/admin/presentation/widgets/delete_plan_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/shared_widgets/bottom_nav_bar.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/firebase.dart';
import '../../../home/presentation/widgets/common_card.dart';
import '../widgets/home_app_bar.dart';

class MyTrainingPlanScreen extends StatefulWidget {
  const MyTrainingPlanScreen({super.key});

  @override
  State<MyTrainingPlanScreen> createState() => _MyTrainingPlanScreenState();
}

class _MyTrainingPlanScreenState extends State<MyTrainingPlanScreen> {
  final planController = TextEditingController();
  List<PlanEntity> plans = [];
  @override
  initState() {
    BlocProvider.of<PlanBloc>(context)
        .add(FetchUserPlansEvent(uId: getUserId()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 20.0),
                CommonCard(
                  headingTitle: "Persönlicher Trainingsplan",
                  body: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: BlocConsumer<PlanBloc, PlanBlocState>(
                          builder: (context, state) {
                        if (state is FetchUserPlansLoading &&
                            plans.length == 0) {
                          return Align(
                            alignment: Alignment.center,
                            child: Transform.scale(
                                scale: 0.7, child: const LoadingAnimation()),
                          );
                        } else if (state is FetchUserPlansSuccess ||
                            plans.length > 0) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: plans.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  key: Key(plans[index].id!),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    final bool res = await showDeletePlanDialog(
                                        context, plans[index].id!);

                                    return res;
                                  },
                                  child: Card(
                                    color: primaryColor,
                                    elevation: 2.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      title: Text(
                                        plans[index].planDescription,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: white),
                                      ),

                                      trailing: Checkbox(
                                        value: plans[index].completed,
                                        onChanged: (status) {
                                          if (state is! UpdatePlanLoading)
                                            BlocProvider.of<PlanBloc>(context)
                                                .add(UpdatePlanEvent(
                                                    description: plans[index]
                                                        .planDescription,
                                                    id: plans[index].id!,
                                                    compeleted: !plans[index]
                                                        .completed));
                                        },
                                        activeColor: Colors.green[300],
                                        side: BorderSide(
                                            color: primaryLightColor),
                                      ),
                                      // You can add more details here if needed
                                      // subtitle: Text('ID: ${clients[index].uId}'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox();
                      }, listener: (context, state) {
                        if (state is FetchUserPlansSuccess) {
                          setState(() {
                            plans = state.plans;
                          });
                        }
                        if (state is UpdatePlanSuccess) {
                          BlocProvider.of<PlanBloc>(context)
                              .add(FetchUserPlansEvent(uId: getUserId()));

                          showCustomMessage(context, 'Status Updated!',
                              isError: false);
                        }
                        if (state is DeletePlanSuccess) {
                          BlocProvider.of<PlanBloc>(context)
                              .add(FetchUserPlansEvent(uId: getUserId()));

                          showCustomMessage(context, 'Plan Deleted!',
                              isError: false);
                        }
                        if (state is UpdatePlanFailure) {
                          showCustomMessage(
                            context,
                            state.errorMessage,
                          );
                        }
                        if (state is FetchUserPlansFailure) {
                          showCustomMessage(
                            context,
                            state.errorMessage,
                          );
                        }
                      })),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(activeIndex: 1));
  }
}
