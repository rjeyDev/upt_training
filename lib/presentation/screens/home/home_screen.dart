import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upt_training/presentation/navigation/navigation.dart';
import 'package:upt_training/presentation/widgets/buttons/primary_button.dart';
import 'package:upt_training/ui_kit/app_color.dart';
import 'package:upt_training/ui_kit/app_text_style.dart';

import '../../../domain/models/user.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        users = state.users?.where((element) => element.id != state.user?.id).toList() ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: AppTextStyle.s18w600Black(context),
            ),
          ),
          body: users.isEmpty
              ? const Center(
                  child: Text('Users list is empty'),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      context.pushRoute(ProfileRoute(isMyProfile: false, user: users[index]));
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.primary,
                      child: users[index].photo != null && (users[index].photo?.isNotEmpty ?? false)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(users[index].photo ?? ''),
                                height: 46,
                                width: 46,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/profile.svg',
                              height: 30,
                              color: AppColor.white,
                            ),
                    ),
                    title: Text(
                      '${users[index].fullName}, ${users[index].age}',
                      style: AppTextStyle.s16w500Black(context),
                    ),
                    subtitle: Text(
                      users[index].country ?? '',
                      style: AppTextStyle.s14w400Black(context),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      height: 30,
                      child: PrimaryButton(
                        child: Text(
                          'Follow',
                          style: AppTextStyle.s14w500White(context),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
