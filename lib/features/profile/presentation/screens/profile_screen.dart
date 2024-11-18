///
/// profile_screen.dart
/// lib/features/profile/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/features/account/domain/entities/profile/profile_entity.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_widgets.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordConfirmation = new TextEditingController();

  bool isLoading = false;

  String? error;

  void handleRegister(BuildContext context) async {
    final _api = getIt<Api>();

    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushNamed(ROUTER.home);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    await Future.delayed(Duration.zero);
    final profile = ModalRoute.of(context)!.settings.arguments as ProfileEntity;
    _emailController.text = profile.email ?? "indramahesa128@gmail.com.";
    _nameController.text = profile.name ?? "Indra Mahesa.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Ubah Akun',
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
                    controller: _nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
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
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 10, 8.0, 0.0),
                  child: TextFormField(
                    autofocus: true,
                    readOnly: true,
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
                SizedBox(height: 20),
                Text(
                  "*Abaikan jika tidak ingin mengubah password",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Plus Jakarta Sans',
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 8.0, 0.0),
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 10, 8.0, 0.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _passwordConfirmation,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Field ini wajib diisi";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    loading: isLoading,
                    onPressed: () {
                      handleRegister(context);
                    },
                    text: 'Ubah Akun',
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
