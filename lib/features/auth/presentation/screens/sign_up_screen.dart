import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_field.dart';
import '../../../../core/shared_widgets/logo.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/or_divider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

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
                'Account erstellen',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: primaryColor, fontWeight: FontWeight.w500),
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
                controller: passwordController,
              ),
              SizedBox(height: 4.h),
              CustomButton(buttonText: "Sign up", onPressed: () {}),
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
    );
  }
}
