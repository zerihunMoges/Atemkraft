import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/shared_widgets/custom_button.dart';
import 'package:atemkraft/core/shared_widgets/custom_text_field.dart';
import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/core/utils/validators.dart';
import 'package:atemkraft/features/auth/domain/entity/profile_entity.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_events.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController weightController;
  late TextEditingController sizeController;
  late String _phoneEditingController;
  late TextEditingController dateController;
  late TextEditingController yearController;
  late TextEditingController monthController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(const GetProfileEvent());
    super.initState();
    nameController = TextEditingController();
    weightController = TextEditingController();
    sizeController = TextEditingController();
    _phoneEditingController = '';
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    sizeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Account Information'),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: BlocConsumer<ProfileBloc, ProfileBlocStates>(
                  builder: (context, state) {
                bool readOnly =
                    state is GetProfileLoading || state is EditProfileLoading;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoRow(
                        'Name',
                        CustomTextField(
                          readOnly: readOnly,
                          label: 'Vollständiger Name',
                          controller: nameController,
                          validator: Validators.fullNameValidator,
                        ),
                        context),
                    infoRow(
                        'Date of Birth',
                        CustomTextField(
                          readOnly: readOnly,
                          label: '',
                          controller: dateController,
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              dateController.text =
                                  DateFormat('d MMMM, y').format(pickedDate);
                            }
                          },
                        ),
                        context),
                    infoRow(
                        'Weight',
                        CustomTextField(
                          readOnly: readOnly,
                          label: 'weight in kg',
                          keyboardType: TextInputType.number,
                          controller: weightController,
                        ),
                        context),
                    infoRow(
                        'Size',
                        CustomTextField(
                            readOnly: readOnly,
                            label: 'Size in ft',
                            keyboardType: TextInputType.number,
                            controller: sizeController),
                        context),
                    infoRow(
                        'Phone Number',
                        IntlPhoneField(
                          readOnly: readOnly,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            focusColor: primaryColor,
                            border: const UnderlineInputBorder(),
                            label: Text("Mobile Number",
                                style: Theme.of(context).textTheme.labelSmall),
                          ),
                          initialCountryCode: 'DU',
                          flagsButtonPadding: const EdgeInsets.all(16),
                          dropdownIconPosition: IconPosition.trailing,
                          flagsButtonMargin:
                              const EdgeInsets.only(right: 20, bottom: 0),
                          dropdownTextStyle:
                              Theme.of(context).textTheme.bodySmall,
                          dropdownDecoration: BoxDecoration(
                            border: Border.all(color: black.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (phone) {
                            // Handle phone number changes

                            setState(() {
                              _phoneEditingController = phone.completeNumber;
                            });
                          },
                        ),
                        context),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          state is EditProfileLoading ||
                                  state is GetProfileLoading
                              ? Center(
                                  child: Transform.scale(
                                      scale: 0.3,
                                      child: const LoadingAnimation()))
                              : CustomButton(
                                  buttonText: 'Save',
                                  width: 35.w,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(EditProfileEvent(
                                        profilePayload: ProfilePayload(
                                            fullName:
                                                nameController.text.trim(),
                                            weight: weightController.text,
                                            size: sizeController.text,
                                            phonenumber:
                                                _phoneEditingController,
                                            dateOfBirth: dateController.text),
                                      ));
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              }, listener: (context, state) {
                if (state is EditProfileSuccess) {
                  BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
                }
                if (state is EditProfileFailure) {
                  showCustomMessage(context, state.errorMessage);
                }

                if (state is GetProfileFailure) {
                  showCustomMessage(context, state.errorMessage);
                }
              }),
            )));
  }
}

Widget infoRow(String label, Widget controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16)),
        const SizedBox(height: 8),
        controller,
      ],
    ),
  );
}
