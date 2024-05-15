import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upt_training/core/extensions/string_extensions.dart';
import 'package:upt_training/presentation/widgets/buttons/primary_button.dart';

import '../../../ui_kit/app_color.dart';
import '../../../ui_kit/app_text_style.dart';
import '../../../ui_kit/scaled_size.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../navigation/navigation.dart';
import '../../widgets/text_fields/app_text_field.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  final Function(bool) onResult;

  const RegistrationScreen({required this.onResult, super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Registration',
              style: AppTextStyle.s18w600Black(context),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 54),
                        AppTextField(
                          height: 75,
                          controller: emailController,
                          formKey: _formKey,
                          title: 'Email',
                          validator: (value) {
                            if (value == null || !value.isValidEmail()) {
                              return 'Enter email address';
                            }
                            if (state.users?.any((user) => user.email == value) ?? false) {
                              return 'This email is in use';
                            }
                            return null;
                          },
                        ),
                        AppTextField(
                          formKey: _formKey,
                          controller: passwordController,
                          height: 75,
                          title: 'Password',
                          hintText: 'Minimum 6 characters',
                          obscureText: true,
                          validator: (value) {
                            if ((value?.length ?? 0) < 6) {
                              return 'Minimum 6 characters';
                            }
                            return null;
                          },
                        ),
                        AppTextField(
                          formKey: _formKey,
                          height: 75,
                          title: 'Repeat password',
                          hintText: 'Minimum 6 characters',
                          obscureText: true,
                          onChanged: (value) {
                            if ((value?.length ?? 0) > 5) {
                              _formKey.currentState?.validate();
                            }
                          },
                          validator: (value) {
                            if ((value?.length ?? 0) < 6) {
                              return 'Minimum 6 characters';
                            } else if (value != passwordController.text) {
                              return 'Repeat password above';
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
                              'Continue',
                              style: AppTextStyle.s14w500White(context),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.pushRoute(
                                  EditProfileRoute(email: emailController.text, password: passwordController.text, isEditing: false),
                                );
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
                                'Already have an account?',
                                style: AppTextStyle.s14w400Black(context),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.maybePop();
                                },
                                child: Text(
                                  'Sign in',
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
            ),
          ),
        );
      },
    );
  }
}
