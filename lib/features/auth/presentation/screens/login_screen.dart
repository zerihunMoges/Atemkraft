import 'package:atemkraft/features/auth/presentation/bloc/auth_bloc.dart';
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
import '../../../../core/utils/firebase.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entity/user_entity.dart';
import '../widgets/forgot_password_popup.dart';
import '../widgets/or_divider.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
                  'Welcome back to ATEMKRAFT',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: primaryColor, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Login to my Account',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: primaryColor, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
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
                    controller: usernameController,
                    validator: Validators.emailValidator),
                SizedBox(height: 3.h),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showForgotPasswordDialog(context);
                    },
                    child: Text('Passwort vergessen',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)),
                  ),
                ),
                SizedBox(height: 4.h),
                BlocConsumer<AuthBloc, AuthBlocStates>(
                    builder: (context, state) {
                  if (state is LoginLoading) {
                    return const LoadingAnimation();
                  }
                  return CustomButton(
                      buttonText: "Login",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            payload: AuthPayload(
                              email: usernameController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          ));
                        }
                      });
                }, listener: (context, state) async {
                  if (state is LoginSuccess) {
                    final isAdmin = await isUserAdmin();
                    if (!isAdmin) {
                      goToHome();
                    } else {
                      goToAdmin();
                    }
                  } else if (state is LoginFailure) {
                    showCustomMessage(context, state.errorMessage);
                  }
                }),
                SizedBox(height: 2.5.h),
                const OrDivider(),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Noch kein Account ',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: "Montserrat",
                            )),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            payload: AuthPayload(
                              email: usernameController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          ));
                        }

                        context.go(AppRoutes.signUp);
                      },
                      child: Text('Sign up',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: primaryColor,
                                    fontFamily: "Montserrat",
                                  )),
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

  goToHome() {
    context.go(AppRoutes.home);
  }

  goToAdmin() {
    context.go(AppRoutes.adminHome);
  }
}
