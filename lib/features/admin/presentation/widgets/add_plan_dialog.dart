import 'package:atemkraft/features/admin/presentation/bloc/user_plans_bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/theme/colors.dart';

addPlanDialog(
    BuildContext context, TextEditingController controller, String uId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Submit Training Plan",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: primaryColor)),
        content: SizedBox(
          width: 85.w,
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodySmall,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Write plan here...",
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the border radius here
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: primaryColor)),
          ),
          BlocConsumer<PlanBloc, PlanBlocState>(builder: (context, state) {
            if (state is CreatePlanLoading) {
              return TextButton(
                onPressed: null,
                child: Text("Submit",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: primaryColor)),
              );
            }
            return TextButton(
              onPressed: () {
                if (controller.text != '') {
                  BlocProvider.of<PlanBloc>(context).add(
                      CreatePlanEvent(description: controller.text, uId: uId));
                }
              },
              child: Text("Submit",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: primaryColor)),
            );
          }, listener: (context, state) {
            if (state is CreatePlanFailure) {
              showCustomMessage(
                context,
                state.errorMessage,
              );
            } else if (state is CreatePlanSuccess) {
              controller.clear();
              showCustomMessage(context, 'Plan successfully created!',
                  isError: false);
              BlocProvider.of<PlanBloc>(context)
                  .add(FetchUserPlansEvent(uId: uId));
              context.pop();
            }
          }),
        ],
      );
    },
  );
}
