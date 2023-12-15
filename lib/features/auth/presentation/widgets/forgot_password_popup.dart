import 'package:atemkraft/core/shared_widgets/loading_animation.dart';
import 'package:atemkraft/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared_widgets/custom_text_field.dart';
import '../../../../core/shared_widgets/error_snake_bar.dart';
import '../../../../core/utils/validators.dart';

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Forgot Password',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Enter your email to reset your password:',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            CustomTextField(
                validator: Validators.emailValidator,
                controller: _emailController,
                label: 'email'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                BlocConsumer<AuthBloc, AuthBlocStates>(
                    builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return Transform.scale(scale:0.6,child: const LoadingAnimation());
                  }
                  return TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          ForgotPasswordEvent(
                              email: _emailController.text.trim()),
                        );
                      }
                    },
                    child: Text('Reset',
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                }, listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    showCustomMessage(context,
                        "A password reset link has been sent to your email.",
                        isError: false);
                    context.pop();
                  } else if (state is ForgotPasswordFailure) {
                    showCustomMessage(context, state.errorMessage,
                        isError: true);
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  onResetPassword() {}

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

// To display the forgot password dialog, use this code wherever needed:
void showForgotPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ForgotPasswordDialog(); // Your forgot password dialog widget
    },
  );
}
