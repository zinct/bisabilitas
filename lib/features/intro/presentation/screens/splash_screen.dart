///
/// splash_screen.dart
/// lib/features/intro/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'dart:async';

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];

  @override
  void initState() {
    super.initState();

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   // // Get the media sharing coming from outside the app while the app is closed.
    // });
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        _sharedFiles.forEach((f) {
          RegExp urlPattern = RegExp(r'(https?:\/\/[^\s]+)');
          String? url = urlPattern.firstMatch(f.path)?.group(0);

          if (f.type == SharedMediaType.text) {
            if (url != null) {
              Navigator.of(context).pushReplacementNamed(ROUTER.pageDetail, arguments: url);
            }
          }
        });

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      });
    });

    checkCredentials();
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
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
          child: Stack(
            children: [
              Image.asset(
                'assets/images/splash.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Group_39524.png',
                        width: 150.0,
                        height: 160.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
