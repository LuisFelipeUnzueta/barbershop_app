import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop_app/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barbershop_app/src/core/ui/barbershop_theme.dart';
import 'package:barbershop_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop_app/src/features/auth/login/login_page.dart';
import 'package:barbershop_app/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barbershop_app/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'features/auth/register/user/user_register_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BarbershopLoader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            title: "Barbershop",
            theme: BarbershopTheme.themeData,
            navigatorKey: BarbershopNavGlobalKey.instance.navKey ,
            navigatorObservers: [asyncNavigatorObserver],
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/auth/register/user': (_) => const UserRegisterPage(),
              '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
              '/home/adm': (_) => const LoginPage(),
              '/home/employee': (_) => const LoginPage(),
            },
          );
        });
  }
}
