import 'package:atemkraft/core/routes/app_routes.dart';
import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/shared_widgets/custom_button.dart';
import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_events.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  ProfilePayload profile = ProfilePayload();
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(const GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Account Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: BlocConsumer<ProfileBloc, ProfileBlocStates>(
            builder: (context, state) {
          if (state is GetProfileSuccess) {}
          if (state is GetProfileLoading) {
            return const LoadingAnimation();
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoRow('Name', profile.fullName ?? '-', context),
                infoRow(
                    'Date of Birth',
                    profile.dateOfBirth != null
                        ? DateFormat('d MMMM, y').format(profile.dateOfBirth!)
                        : '-',
                    context),
                infoRow(
                    'Weight',
                    profile.weight != null ? '${profile.weight} kg' : '-',
                    context),
                infoRow(
                    'Size',
                    profile.size != null ? '${profile.size} ft tall' : '-',
                    context),
                infoRow('Phone Number', profile.phonenumber ?? '-', context),
                infoRow(
                    'Email Address', authInstance.currentUser!.email!, context),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          borderOnly: true,
                          buttonText: 'Edit',
                          onPressed: () => context.push(AppRoutes.editProfile),
                          width: 35.w,
                          borderColor: primaryColor),
                    ],
                  ),
                )
              ]);
        }, listener: (context, state) {
          if (state is GetProfileSuccess) {
            setState(() {
              profile = state.profilePayload;
            });
          }
          if (state is GetProfileFailure) {
            showCustomMessage(context, state.errorMessage);
          }
        }),
      ),
    );
  }
}

Widget infoRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16)),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, color: Colors.black.withOpacity(0.5))),
      ],
    ),
  );
}
