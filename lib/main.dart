import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upt_training/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:upt_training/presentation/navigation/navigation.dart';

import 'data/datasource/local/service_locator/service_locator.dart';
import 'data/datasource/remote/jwt.dart';

void main() async {
  setupServiceLocator();
  await Hive.initFlutter();
  await sl.get<JwtBox>().fetchData();
  runApp(UptTraining());
}

class UptTraining extends StatelessWidget {
  UptTraining({super.key});

  final _appRouter = sl.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'UPT training',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.config(
          deepLinkBuilder: (deepLink) {
            return deepLink;
          },
        ),
      ),
    );
  }
}
