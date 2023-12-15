import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/presentation/widgets/common_card.dart';
import '../../../home/presentation/widgets/home_app_bar.dart';
import '../bloc/admin_bloc.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  initState() {
    BlocProvider.of<AdminBloc>(context).add(FetchClientsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
              BlocProvider.of<AdminBloc>(context).add(FetchClientsEvent());

            },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 20.0),
                RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<AdminBloc>(context)
                        .add(FetchClientsEvent());
                  },
                  child: CommonCard(
                    headingTitle: "List of Clients",
                    body: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12.0),
                          BlocConsumer<AdminBloc, AdminBlocState>(
                              builder: (context, state) {
                            if (state is FetchClientsLoading) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.sizeOf(context).width * 0.25),
                                child: const LoadingAnimation(),
                              );
                            } else if (state is FetchClientsSuccess) {
                              return SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.78,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.clients.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Card(
                                      color: primaryColor,
                                      elevation: 2.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ListTile(
                                        onTap: () {
                                          context.push(AppRoutes.adminUserPlan,
                                              extra: {
                                                'uId': state.clients[index].uId,
                                                'email':
                                                    state.clients[index].email
                                              });
                                        },
                                        title: Text(
                                          state.clients[index].email,
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
                            if (state is FetchClientsFailure) {
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
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(
      //   activeIndex: 0,
      // ),
    );
  }
}
