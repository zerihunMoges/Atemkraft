import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/features/admin/presentation/bloc/user_plans_bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

bool showDeletePlanDialog(BuildContext context, String id) {
  bool removeSuccess = false;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(25),
        title: Text('Delete Plan?',
            style: Theme.of(context).textTheme.labelMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                BlocConsumer<PlanBloc, PlanBlocState>(
                    builder: (context, state) {
                  return TextButton(
                      onPressed: state is! DeletePlanLoading
                          ? () {
                              BlocProvider.of<PlanBloc>(context)
                                  .add(DeletePlanEvent(id: id));
                            }
                          : () {},
                      child: Text('Sure',
                          style: Theme.of(context).textTheme.bodySmall));
                }, listener: (context, state) {
                  if (state is DeletePlanSuccess) {
                    removeSuccess = true;
                    context.pop();
                  } else if (state is DeletePlanFailure) {
                    showCustomMessage(context, state.errorMessage);
                  }
                }),
              ],
            ),
          ],
        ),
      );
    },
  );

  return removeSuccess;
}
