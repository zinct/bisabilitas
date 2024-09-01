///
/// splash_screen.dart
/// lib/features/intro/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  void checkCredentials() async {
    try {
      final box = await Hive.openBox(HIVE.databaseName);
      final token = box.get(HIVE.tokenData);
      if (token == null) {
        Navigator.of(context).pushReplacementNamed(ROUTER.onboarding);
      }

      box.put(HIVE.tokenData, token);
      getIt<Api>().setToken(token);

      final response = await getIt<Api>().get('profile');
      final model = BaseModel.fromJson(response.data);

      if (model.success ?? false) {
        Navigator.of(context).pushReplacementNamed(ROUTER.home);
      } else {
        Navigator.of(context).pushReplacementNamed(ROUTER.onboarding);
      }
    } catch (err) {
      Navigator.of(context).pushReplacementNamed(ROUTER.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Align(
          alignment: const AlignmentDirectional(0.0, -1.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Group_39524.png',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
