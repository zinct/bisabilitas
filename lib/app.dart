import 'dart:io';

import 'package:bisabilitas/features/auth/presentation/screens/login_screen.dart';
import 'package:bisabilitas/features/intro/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

import 'core/constants/locale.dart';
import 'core/constants/router.dart';
import 'core/resources/colors.dart';
import 'core/utils/scroll_behaviour_utils.dart';
import 'injection_container.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          routes: {
            ROUTER.splash: (context) => const SplashScreen(),
            // ROUTER.intro: (context) => const IntroScreen(),
            // ROUTER.onboarding: (context) => const OnboardingScreen(),
            ROUTER.login: (context) => const LoginScreen(),
            // ROUTER.register: (context) => const RegisterScreen(),
            // ROUTER.main: (context) => const MainScreen(),
          },
          initialRoute: ROUTER.splash,
          home: child,
          debugShowCheckedModeBanner: false,
          // Flutter Toast
          // builder: (context, child) {
          //   return ScrollConfiguration(
          //     behavior: const ScrollBehaviourUtils(),
          //     child: child ?? Container(),
          //   );
          // },

          // Theme
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: BaseColors.primary,
            ),
          ),
        );
      },
    );
  }
}
