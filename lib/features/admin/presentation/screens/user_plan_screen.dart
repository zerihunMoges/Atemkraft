import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/presentation/widgets/common_card.dart';
import '../bloc/admin_bloc.dart';
import '../widgets/add_plan_dialog.dart';

class UserPlansScreen extends StatefulWidget {
  final String uId;
  final String email;
  const UserPlansScreen({super.key, required this.uId, required this.email});

  @override
  State<UserPlansScreen> createState() => _UserPlansScreenState();
}

class _UserPlansScreenState extends State<UserPlansScreen> {
  final planController = TextEditingController();
  @override
  initState() {
    BlocProvider.of<AdminBloc>(context)
        .add(FetchUserPlansEvent(uId: widget.uId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          leading: BackButton(onPressed: () {
            BlocProvider.of<AdminBloc>(context).add(FetchClientsEvent());

            Navigator.pop(context);
          })),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              CommonCard(
                headingTitle: "${widget.email} - Plans",
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12.0),
                      BlocConsumer<AdminBloc, AdminBlocState>(
                          builder: (context, state) {
                        if (state is FetchUserPlansLoading) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.sizeOf(context).width * 0.25),
                            child: const LoadingAnimation(),
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            addPlanDialog(context, planController, widget.uId);
          },
          child: const Icon(Icons.add, color: white)),
    );
  }
}
