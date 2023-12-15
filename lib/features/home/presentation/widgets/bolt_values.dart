import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_states.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BOLTValues extends StatefulWidget {
  const BOLTValues({super.key});

  @override
  State<BOLTValues> createState() => _BOLTValuesState();
}

class _BOLTValuesState extends State<BOLTValues> {
  final List<Map<String, dynamic>> boltValues = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          headingPadding: 20,
          headingTitle: "Letzte BOLT Werten",
          headingTitleStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: white, fontSize: 14),
          centerHeading: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<BoltBloc, BoltBlocStates>(builder: (context, state) {
                if (state is GetBoltsLoading) {
                  return const LoadingAnimation();
                }
                return state is GetBoltsSuccess
                    ? Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.bolts.length,
                          itemBuilder: (context, index) {
                            final seconds = state.bolts[index].duration;
                            final timestamp = state.bolts[index].timestamp;

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Erstellt am: ${formatDateTime(timestamp!)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: black),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  '${seconds.toString()} SEK',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: black,
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : Container();
              }, listener: (context, state) {
                if (state is GetBoltsFailure) {
                  showCustomMessage(context, state.errorMessage);
                }
              }),
            ],
          ),
        )
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDateTime = DateFormat.yMMMd().format(dateTime);
    return formattedDateTime;
  }
}
