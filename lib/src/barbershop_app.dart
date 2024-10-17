import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop_app/src/core/ui/barbershop_theme.dart';
import 'package:barbershop_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop_app/src/features/auth/login/login_page.dart';
import 'package:barbershop_app/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

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
            navigatorObservers: [asyncNavigatorObserver],
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
            },
          );
        });
  }
}
