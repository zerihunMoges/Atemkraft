import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_events.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_states.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BOLTValues extends StatefulWidget {
  const BOLTValues({super.key});

  @override
  State<BOLTValues> createState() => _BOLTValuesState();
}

class _BOLTValuesState extends State<BOLTValues> {
  List<BoltPayload> boltValues = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          headingPadding: 20,
          headingTitle: "Letzter BOLT-Wert.",
          headingTitleStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: white, fontSize: 14),
          centerHeading: false,
          body:
              BlocConsumer<BoltBloc, BoltBlocStates>(builder: (context, state) {
            if (state is GetBoltsLoading && boltValues.isEmpty) {
              return Center(
                  child: Transform.scale(
                      scale: 0.3, child: const LoadingAnimation()));
            }
            return state is GetBoltsSuccess || boltValues.isNotEmpty
                ? SizedBox(
                    child: boltValues.isNotEmpty
                        ? SizedBox(
                            height: 20.h,
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 1.h),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: boltValues.length,
                              itemBuilder: (context, index) {
                                final duration = boltValues[index].duration;
                                final timestamp = boltValues[index].timestamp;
                                final boltId = boltValues[index].id;
                                return Dismissible(
                                  key: Key(boltId!),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    final bool res = await showDeleteBoltDialog(
                                        context, boltId, duration);

                                    return res;
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Erstellt am: ${formatDateTime(timestamp!)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: black),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 4.w,
                                      )),
                                      SizedBox(
                                        width: 20.w,
                                        child: Text(
                                          '${duration.toString()} SEK',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: black,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.remove,
                                            color: Colors.red[400]),
                                        onTap: () {
                                          showDeleteBoltDialog(
                                              context, boltId, duration);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            'No records!',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                  )
                : Container();
          }, listener: (context, state) {
            if (state is GetBoltsSuccess) {
              setState(() {
                state.bolts
                    .sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
                boltValues = state.bolts;
              });
            }
            if (state is GetBoltsFailure) {
              showCustomMessage(context, state.errorMessage);
            }
            if (state is RemoveBoltFailure) {
              showCustomMessage(context, state.errorMessage);
            }
          }),
        )
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDateTime = DateFormat.yMMMd().format(dateTime);
    return formattedDateTime;
  }

  bool showDeleteBoltDialog(BuildContext context, String boltId, int duration) {
    bool removeSuccess = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(25),
          title: Text('Delete Record $duration Sek?',
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
                  BlocConsumer<BoltBloc, BoltBlocStates>(
                      builder: (context, state) {
                    return TextButton(
                        onPressed: state is! RemoveBoltLoading
                            ? () {
                                BlocProvider.of<BoltBloc>(context)
                                    .add(RemoveBoltEvent(
                                  boltId: boltId,
                                ));
                              }
                            : () {},
                        child: Text('Sure',
                            style: Theme.of(context).textTheme.bodySmall));
                  }, listener: (context, state) {
                    if (state is RemoveBoltSuccess) {
                      BlocProvider.of<BoltBloc>(context).add(GetBoltsEvent(
                        user: getUserId(),
                      ));
                      removeSuccess = true;
                      context.pop();
                    } else if (state is RemoveBoltFailure) {
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
}
