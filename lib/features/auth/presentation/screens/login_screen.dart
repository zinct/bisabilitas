///
/// login_screen.dart
/// lib/features/auth/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/components/buttons/primary_button.dart';
import 'package:bisabilitas/core/components/textfields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void googleSignIn() async {
    final supabase = Supabase.instance.client;

    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '763870623181-u5pf5p0vsabto6nug2drhovc0e771nl0.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '763870623181-4r6eeue1misgj899pp5abngk09njov06.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    var response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const SizedBox(height: 200),
                const Text("Email"),
                const PrimaryTextField(),
                const SizedBox(height: 30),
                const Text("Password"),
                const PrimaryTextField(),
                const SizedBox(height: 30),
                PrimaryButton(onTap: () {}, text: "Login"),
                const SizedBox(height: 30),
                PrimaryButton(
                  onTap: googleSignIn,
                  text: "Google",
                  backgroundColor: Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
