import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_field.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/shared_widgets/loading_animation.dart';
import '../../../../core/shared_widgets/logo.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entity/user_entity.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/or_divider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(35.0),
        color: white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(),
                Text(
                  'Account erstellen',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: primaryColor, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Vollständiger Name',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 1.h),
                CustomTextField(
                  label: 'Vollständiger Name',
                  validator: Validators.fullNameValidator,
                  controller: fullNameController,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 1.h),
                CustomTextField(
                  label: 'Email',
                  validator: Validators.emailValidator,
                  controller: emailController,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Password',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 1.h),
                CustomTextField(
                  label: 'Password',
                  isPassword: true,
                  validator: Validators.passwordValidator,
                  controller: passwordController,
                ),
                SizedBox(height: 4.h),
                BlocConsumer<AuthBloc, AuthBlocStates>(
                    builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const LoadingAnimation();
                  }
                  return CustomButton(
                      buttonText: "Sign Up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                            payload: AuthPayload(
                              fullName: fullNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          ));
                        }
                      });
                }, listener: (context, state) {
                  if (state is SignUpSuccess) {
                    context.go(AppRoutes.home);
                  } else if (state is LoginFailure) {
                    showErrorMessage(context, state.errorMessage);
                  }
                }),
                SizedBox(height: 2.5.h),
                const OrDivider(),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bereits einen Account? ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Montserrat",
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.login);
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: primaryColor,
                              fontFamily: "Montserrat",
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
