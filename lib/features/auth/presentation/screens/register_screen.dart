///
/// register_screen.dart
/// lib/features/auth/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_widgets.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  String? error;
  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  final TextEditingController _passwordConfirmation = new TextEditingController();

  void handleRegister(BuildContext context) async {
    final _api = getIt<Api>();

    setState(() {
      isLoading = true;
    });
    final response = await _api.post('register', formObj: {
      'email': _emailController.text,
      'name': _nameController.text,
      'password': _passwordController.text,
      'password_confirmation': _passwordConfirmation.text,
    });
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
        error = model.message;
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
                    'Registrasi Akun',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Tambahkan nama, tanggal lahir, jenis kelamin, dan\njenis disabilitas agar kami dapat menyesuaikan ke-\nbutuhanmu.',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Inter',
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
                    obscureText: false,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Masukan nama lengkap',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
                    obscureText: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Masukan alamat email',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Masukan password',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
                    obscureText: true,
                    controller: _passwordConfirmation,
                    decoration: InputDecoration(
                      labelText: 'Masukan konfirmasi password',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Kembali',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFF2DFCB),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter',
                            color: const Color(0xFF995F25),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
                    onPressed: () => handleRegister(context),
                    text: 'Lanjut',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFCD7F32),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
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
