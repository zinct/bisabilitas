///
/// login_screen.dart
/// lib/features/auth/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/components/buttons/primary_button.dart';
import 'package:bisabilitas/core/components/textfields/primary_text_field.dart';
import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_widgets.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String? error;

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  void handleRegister(BuildContext context) async {
    final _api = getIt<Api>();

    setState(() {
      isLoading = true;
    });
    final response = await _api.post('login', formObj: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    print("object $response");
    setState(() {
      isLoading = false;
    });

    final model = BaseModel.fromJson(response.data);

    if (model.success ?? false) {
      // Store token to headers
      _api.setToken(model.data['token']);

      // Store token to local storage
      final box = await Hive.openBox(HIVE.databaseName);
      box.put(HIVE.tokenData, model.data['token']);

      Navigator.of(context).pushNamed(ROUTER.home);
    }

    if (model.code == 422) {
      setState(() {
        error = "Email atau password salah!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Jangan lupa login menggunakan akun yang sudah\nkamu daftarkan sebelumnya!',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Plus Jakarta Sans',
                      color: const Color(0xFF909090),
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 25.0, 8.0, 0.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Field ini wajib diisi";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
                error != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          error ?? "",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Plus Jakarta Sans',
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    : Container(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () {},
                    text: 'Lupa Kata Sandi?',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFF2DFCB),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: const Color(0xFF995F25),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    loading: isLoading,
                    onPressed: () {
                      handleRegister(context);
                    },
                    text: 'Login',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFCD7F32),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
