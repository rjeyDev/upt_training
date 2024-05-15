import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:upt_training/presentation/navigation/navigation.dart';
import 'package:upt_training/presentation/widgets/buttons/primary_button.dart';
import 'package:upt_training/ui_kit/app_color.dart';
import 'package:upt_training/ui_kit/app_text_style.dart';

import '../../../data/datasource/local/service_locator/service_locator.dart';
import '../../../domain/models/user.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/text_fields/app_text_field.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  final bool isEditing;
  final String email;
  final String password;

  const EditProfileScreen({super.key, required this.email, required this.password, required this.isEditing});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  XFile? profilePhoto;
  String? photoPath;
  List<String?> workingDays = [];

  late List<String> weekdays;

  @override
  void initState() {
    weekdays = DateFormat.EEEE().dateSymbols.STANDALONEWEEKDAYS;
    if (widget.isEditing) {
      fillEditingData();
    }
    super.initState();
  }

  fillEditingData() {
    AuthState state = context.read<AuthBloc>().state;
    User user = state.user!;
    photoPath = user.photo;
    fullnameController.text = user.fullName ?? '';
    descriptionController.text = user.description ?? '';
    ageController.text = user.age ?? '';
    countryController.text = user.country ?? '';
    languageController.text = user.language ?? '';
    experienceController.text = user.experience ?? '';
    workingDays = user.workingDays ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.action == AuthAction.register) {
          sl.get<AppRouter>().pushAndPopUntil(const BottomNavigatorRoute(), predicate: (route) => false);
        }
        if (state.action == AuthAction.editProfile) {
          context.maybePop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              'Profile Data',
              style: AppTextStyle.s18w600Black(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColor.primary,
                          child: profilePhoto != null || photoPath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 76,
                                    width: 76,
                                    child: Image.file(
                                      File(profilePhoto?.path ?? photoPath!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : SvgPicture.asset(
                                  'assets/icons/profile.svg',
                                  height: 30,
                                  color: AppColor.white,
                                ),
                        ),
                        const SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: PrimaryButton(
                                onPressed: () async {
                                  profilePhoto = await ImagePicker().pickImage(source: ImageSource.gallery);
                                  setState(() {});
                                },
                                child: Text(
                                  'Choose from gallery',
                                  style: AppTextStyle.s14w500White(context),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: PrimaryButton(
                                onPressed: () async {
                                  profilePhoto = await ImagePicker().pickImage(source: ImageSource.camera);
                                  setState(() {});
                                },
                                child: Text(
                                  'Use camera',
                                  style: AppTextStyle.s14w500White(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: fullnameController,
                      title: 'Full Name',
                      hintText: 'John Doe',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your full name';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: descriptionController,
                      title: 'About yourself (optional)',
                      validator: (value) {
                        return null;
                      },
                    ),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: experienceController,
                      title: 'Experience',
                      keyboardType: TextInputType.number,
                      hintText: 'Example: 12',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your experience';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: countryController,
                      title: 'Country',
                      hintText: 'Example: Japan',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your country';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: languageController,
                      title: 'Language',
                      hintText: 'Example: English',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your language';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      formKey: _formKey,
                      height: 75,
                      controller: ageController,
                      title: 'Age',
                      keyboardType: TextInputType.number,
                      hintText: 'Example: 38',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your age';
                        }
                        return null;
                      },
                    ),
                    MultiSelectDropDown(
                      hint: 'Select working days',
                      hintStyle: AppTextStyle.s14w400Black(context),
                      selectedOptions: workingDays.map((e) => ValueItem(label: e ?? '', value: e)).toList(),
                      borderWidth: 1,
                      focusedBorderColor: AppColor.primary,
                      focusedBorderWidth: 1,
                      onOptionSelected: (selectedItems) {
                        workingDays = selectedItems.map((e) => e.value ?? '').toList();
                      },
                      options: List.generate(
                        weekdays.length,
                        (index) => ValueItem(
                          label: weekdays[index],
                          value: weekdays[index],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: PrimaryButton(
                          onPressed: () async {
                            if (widget.isEditing) {
                              await editProfile();
                            } else {
                              await createAccount();
                            }
                          },
                          child: Text(
                            widget.isEditing ? 'Save' : 'Create an account',
                            style: AppTextStyle.s14w500White(context),
                          )),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  createAccount() async {
    context.read<AuthBloc>().add(
          AuthEvent.register(
            widget.email,
            widget.password,
            profilePhoto?.path ?? '',
            fullnameController.text,
            descriptionController.text,
            countryController.text,
            ageController.text,
            languageController.text,
            experienceController.text,
            workingDays,
          ),
        );
  }

  editProfile() async {
    context.read<AuthBloc>().add(
          AuthEvent.editProfile(
            profilePhoto?.path ?? photoPath ?? '',
            fullnameController.text,
            descriptionController.text,
            countryController.text,
            ageController.text,
            languageController.text,
            experienceController.text,
            workingDays,
          ),
        );
  }
}
