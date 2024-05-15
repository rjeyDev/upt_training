import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upt_training/core/extensions/string_extensions.dart';

import '../../../ui_kit/app_text_style.dart';
import '../../../ui_kit/scaled_size.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../navigation/navigation.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_fields/app_text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final Function(bool) onResult;

  const LoginScreen({required this.onResult, super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.action == AuthAction.login) {
          widget.onResult(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Login',
              style: AppTextStyle.s18w600Black(context),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 55),
                    AppTextField(
                      formKey: _formKey,
                      controller: emailController,
                      title: 'Email',
                      validator: (value) {
                        if (value == null || !value.isValidEmail()) {
                          return 'Enter email address';
                        }
                        if (!(state.users?.any((user) => user.email == value) ?? false)) {
                          return 'This account does not exist';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 19),
                    AppTextField(
                      height: 80,
                      formKey: _formKey,
                      controller: passwordController,
                      title: 'Password',
                      hintText: 'minimum 6 characters',
                      obscureText: true,
                      validator: (value) {
                        if ((value?.length ?? 0) < 6) {
                          return 'Enter minimum 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScaledSize.widget(context, 54),
                    ),
                    SizedBox(
                      height: 40,
                      child: PrimaryButton(
                        child: Text(
                          'Sign in',
                          style: AppTextStyle.s14w500White(context),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthBloc>().add(AuthEvent.login(emailController.text, passwordController.text));
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppTextStyle.s14w400Black(context),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushRoute(RegistrationRoute(onResult: widget.onResult));
                            },
                            child: Text(
                              'Sign up',
                              style: AppTextStyle.s14w500Primary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
