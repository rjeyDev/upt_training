// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'navigation.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddContentRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddContentScreen(),
      );
    },
    BottomNavigatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomNavigator(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfileScreen(
          key: args.key,
          email: args.email,
          password: args.password,
          isEditing: args.isEditing,
        ),
      );
    },
    HomeNavigatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeNavigatorScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(
          onResult: args.onResult,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileScreen(
          key: args.key,
          isMyProfile: args.isMyProfile,
          user: args.user,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegistrationScreen(
          onResult: args.onResult,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AddContentScreen]
class AddContentRoute extends PageRouteInfo<void> {
  const AddContentRoute({List<PageRouteInfo>? children})
      : super(
          AddContentRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddContentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BottomNavigator]
class BottomNavigatorRoute extends PageRouteInfo<void> {
  const BottomNavigatorRoute({List<PageRouteInfo>? children})
      : super(
          BottomNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required String email,
    required String password,
    required bool isEditing,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            email: email,
            password: password,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.email,
    required this.password,
    required this.isEditing,
  });

  final Key? key;

  final String email;

  final String password;

  final bool isEditing;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, email: $email, password: $password, isEditing: $isEditing}';
  }
}

/// generated route for
/// [HomeNavigatorScreen]
class HomeNavigatorRoute extends PageRouteInfo<void> {
  const HomeNavigatorRoute({List<PageRouteInfo>? children})
      : super(
          HomeNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeNavigatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required dynamic Function(bool) onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    required this.onResult,
    this.key,
  });

  final dynamic Function(bool) onResult;

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    required bool isMyProfile,
    User? user,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            isMyProfile: isMyProfile,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.isMyProfile,
    this.user,
  });

  final Key? key;

  final bool isMyProfile;

  final User? user;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, isMyProfile: $isMyProfile, user: $user}';
  }
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    required dynamic Function(bool) onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<RegistrationRouteArgs> page =
      PageInfo<RegistrationRouteArgs>(name);
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({
    required this.onResult,
    this.key,
  });

  final dynamic Function(bool) onResult;

  final Key? key;

  @override
  String toString() {
    return 'RegistrationRouteArgs{onResult: $onResult, key: $key}';
  }
}
