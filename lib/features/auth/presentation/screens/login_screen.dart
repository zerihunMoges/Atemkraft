import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_field.dart';
import '../../../../core/shared_widgets/logo.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/or_divider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(35.0),
        color: white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppLogo(),
              Text(
                'Welcome back to ATEMKRAFT',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: primaryColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                'Login to my Account',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: primaryColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Username',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                label: 'Username',
                controller: usernameController,
              ),
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
                controller: passwordController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add functionality for 'Passwort vergessen'
                  },
                  child: Text('Passwort vergessen',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: primaryColor)),
                ),
              ),
              SizedBox(height: 4.h),
              CustomButton(
                  buttonText: "Login",
                  onPressed: () {
                    context.go(AppRoutes.home);
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
                      context.go(AppRoutes.signUp);
                    },
                    child: Text('Sign up',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
