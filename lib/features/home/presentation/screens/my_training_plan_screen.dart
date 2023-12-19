import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/features/admin/presentation/bloc/user_plans_bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/shared_widgets/bottom_nav_bar.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/firebase.dart';
import '../../../admin/presentation/bloc/admin_bloc.dart';
import '../../../home/presentation/widgets/common_card.dart';
import '../widgets/home_app_bar.dart';

class MyTrainingPlanScreen extends StatefulWidget {
  const MyTrainingPlanScreen({super.key});

  @override
  State<MyTrainingPlanScreen> createState() => _MyTrainingPlanScreenState();
}

class _MyTrainingPlanScreenState extends State<MyTrainingPlanScreen> {
  final planController = TextEditingController();
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
                      if (state is FetchUserPlansLoading) {
                        return Align(
                          alignment: Alignment.center,
                          child: Transform.scale(
                              scale: 0.7, child: const LoadingAnimation()),
                        );
                      } else if (state is FetchUserPlansSuccess) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.78,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.plans.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: primaryColor,
                                elevation: 2.0,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    state.plans[index].planDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: white),
                                  ),
                                  // You can add more details here if needed
                                  // subtitle: Text('ID: ${clients[index].uId}'),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    }, listener: (context, state) {
                      if (state is FetchUserPlansFailure) {
                        showCustomMessage(
                          context,
                          state.errorMessage,
                        );
                      }
                    }),
                  ),
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
