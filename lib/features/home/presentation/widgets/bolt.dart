import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_events.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_states.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_counter.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/custom_text_field.dart';

class BOLT extends StatefulWidget {
  const BOLT({super.key});

  @override
  State<BOLT> createState() => _BOLTState();
}

class _BOLTState extends State<BOLT> {
  TextEditingController manualInputController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<BoltBloc>(context).add(GetBoltsEvent(user: getUserId()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showInsertDataDialog(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('BOLT Wert manuell eintragen',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 5.w),
              Container(
                width: 10.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        const BOLTValues(),
        SizedBox(
          height: 5.h,
        ),
        const BOLTCounter()
      ],
    );
  }

  void showInsertDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(25),
          title: Text('Insert BOLT manually',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextField(
                  controller: manualInputController,
                  label:
                      "Sekunden eintragen..."), // Assuming CustomTextField accepts a controller
              const SizedBox(height: 10), // Adjust as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.pop(); // Close the dialog
                    },
                    child: Text('Cancel',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  BlocConsumer<BoltBloc, BoltBlocStates>(
                      builder: (context, state) {
                    return TextButton(
                      onPressed: state is! AddBoltLoading
                          ? () {
                              final String value = manualInputController.text;

                              if (value != '') {
                                BlocProvider.of<BoltBloc>(context)
                                    .add(AddBoltEvent(
                                  payload:
                                      BoltPayload(duration: int.parse(value)),
                                ));
                              }
                            }
                          : () {},
                      child: Text('Enter',
                          style: Theme.of(context).textTheme.labelMedium),
                    );
                  }, listener: (context, state) {
                    if (state is AddBoltSuccess) {
                      context.pop();
                    } else if (state is AddBoltFailure) {
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
  }
}
