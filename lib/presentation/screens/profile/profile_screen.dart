import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upt_training/data/datasource/remote/jwt.dart';
import 'package:upt_training/ui_kit/app_text_style.dart';

import '../../../data/datasource/local/service_locator/service_locator.dart';
import '../../../domain/models/user.dart';
import '../../../ui_kit/app_color.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../navigation/navigation.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  final bool isMyProfile;
  final User? user;
  const ProfileScreen({super.key, required this.isMyProfile, this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    if (widget.isMyProfile) {
      user = context.read<AuthBloc>().state.user;
    } else {
      user = widget.user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (widget.isMyProfile && state.action == AuthAction.editProfile) {
          user = state.user;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: widget.isMyProfile
                ? [
                    IconButton(
                      onPressed: () {
                        context.pushRoute(EditProfileRoute(
                          email: user!.email!,
                          password: user!.password!,
                          isEditing: true,
                        ));
                      },
                      icon: const Icon(
                        Icons.mode_edit_outline_outlined,
                        color: AppColor.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sl.get<JwtBox>().authenticated = false;
                        sl.get<AppRouter>().pushAndPopUntil(LoginRoute(onResult: (result) {
                          if (result) {
                            sl.get<AppRouter>().replace(const BottomNavigatorRoute());
                          }
                        }), predicate: (route) => false);
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ]
                : null,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColor.secondary,
                            child: user?.photo != null && (user?.photo?.isNotEmpty ?? false)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(user!.photo!),
                                      height: 76,
                                      width: 76,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/profile.svg',
                                    color: AppColor.white,
                                    height: 35,
                                  ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  user?.posts?.length.toString() ?? '0',
                                  style: AppTextStyle.s16w500Black(context),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Posts',
                                  style: AppTextStyle.s12w400Black(context),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  '${user?.experience ?? 0} years',
                                  style: AppTextStyle.s16w500Black(context),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Experience',
                                  style: AppTextStyle.s12w400Black(context),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  user?.language ?? '',
                                  style: AppTextStyle.s16w500Black(context),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Language',
                                  style: AppTextStyle.s12w400Black(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${user?.fullName}, ${user?.age}',
                        style: AppTextStyle.s16w500Black(context),
                      ),
                      Text(
                        user?.country ?? '',
                        style: AppTextStyle.s12w400Black(context),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user?.description ?? '',
                        style: AppTextStyle.s14w400Black(context),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Working days',
                        style: AppTextStyle.s14w500Black(context),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: List.generate(
                          user?.workingDays?.length ?? 0,
                          (index) => Text(
                            '${user?.workingDays?[index]}${index == ((user?.workingDays?.length ?? 0) - 1) ? '' : ', '}',
                            style: AppTextStyle.s14w400Black(context),
                          ),
                        ),
                      ),
                      if (user?.posts?.isEmpty ?? true) ...[
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(alignment: Alignment.center, child: Text('There is no posts yet')),
                      ]
                    ],
                  ),
                ),
              ),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: user?.posts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(user?.posts?[index]?.media ?? ''),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 3,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
