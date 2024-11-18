import 'dart:async';

import 'package:bisabilitas/features/auth/presentation/screens/login_screen.dart';
import 'package:bisabilitas/features/auth/presentation/screens/register_screen.dart';
import 'package:bisabilitas/features/intro/presentation/screens/onboarding_screen.dart';
import 'package:bisabilitas/features/intro/presentation/screens/splash_screen.dart';
import 'package:bisabilitas/features/main/presentation/screens/main_screen.dart';
import 'package:bisabilitas/features/page/presentation/screens/page_detail_screen.dart';
import 'package:bisabilitas/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'core/constants/router.dart';
import 'core/resources/colors.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          routes: {
            ROUTER.splash: (context) => const SplashScreen(),
            ROUTER.onboarding: (context) => const OnboardingScreen(),
            ROUTER.login: (context) => const LoginScreen(),
            ROUTER.register: (context) => RegisterScreen(),
            ROUTER.home: (context) => const MainScreen(),
            ROUTER.pageDetail: (context) => const PageDetailScreen(),
            ROUTER.profile: (context) => ProfileScreen(),
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
