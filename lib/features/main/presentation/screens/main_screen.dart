///
/// home_screen.dart
/// lib/features/main/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'dart:isolate';

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/core/models/list/list_model.dart';
import 'package:bisabilitas/core/widgets/touchable_opacity_widget.dart';
import 'package:bisabilitas/features/account/domain/entities/profile/profile_entity.dart';
import 'package:bisabilitas/features/main/presentation/screens/account_screen.dart';
import 'package:bisabilitas/features/main/presentation/screens/bookmark_screen.dart';
import 'package:bisabilitas/features/main/presentation/screens/home_screen.dart';
import 'package:bisabilitas/features/page/domain/entities/page/page_entity.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_widgets.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  bool isLoading = false;
  bool isProfileLoading = false;
  List<PageEntity> pages = [];
  ProfileEntity? profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPage();
    fetchProfile();
  }

  void fetchPage() async {
    final _api = getIt<Api>();

    setState(() {
      isLoading = true;
    });
    final response = await _api.get('page');

    setState(() {
      isLoading = false;
    });

    final model = ListModel.fromJson(response.data, (p0) => PageEntity.fromJson(p0));
    if (model.success ?? false) {
      setState(() {
        pages = model.data!;
      });
    } else {}
  }

  void fetchProfile() async {
    final _api = getIt<Api>();

    setState(() {
      isProfileLoading = true;
    });
    final response = await _api.get('profile');

    setState(() {
      isProfileLoading = false;
    });

    final model = BaseModel.fromJson(response.data);
    if (model.success ?? false) {
      final profileData = ProfileEntity.fromJson(model.data);

      setState(() {
        profile = profileData;
      });
    } else {}
  }

  final _pageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      const HomeScreen(),
      BookmarkScreen(
        isLoading: isLoading,
        pages: pages,
        onRefresh: () async {
          fetchPage();
          return Future.delayed(Duration.zero);
        },
      ),
      AccountScreen(
        profile: profile,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: widgets,
              ),
            ),
            Container(
              height: 85.h,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TouchableOpacityWidget(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/home-04.png',
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                'Beranda',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: const Color(0xFF020617),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TouchableOpacityWidget(
                      onTap: () {
                        if (profile == null) {
                          Navigator.of(context).pushNamed(ROUTER.onboarding);
                        } else {
                          setState(() {
                            currentIndex = 1;
                          });
                        }
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/bookmark_svgrepo.com.png',
                                width: 40.0,
                                height: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                'Tersimpan',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: const Color(0xFF020617),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TouchableOpacityWidget(
                      onTap: () {
                        if (profile == null) {
                          Navigator.of(context).pushNamed(ROUTER.onboarding);
                        } else {
                          setState(() {
                            currentIndex = 2;
                          });
                        }
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/settings_svgrepo.com_(1).png',
                                width: 40.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                'Pengaturan',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: const Color(0xFF020617),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: currentIndex == 1
          ? Padding(
              padding: EdgeInsets.only(bottom: 80.w),
              child: FloatingActionButton(
                onPressed: () {
                  bool isCreatePageLoading = false;

                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: StatefulBuilder(builder: (
                          BuildContext context,
                          StateSetter setState,
                        ) {
                          return Container(
                            height: 300.h,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Tambahkan URL',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  SizedBox(height: 45.h),
                                  TextFormField(
                                    controller: _pageController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Link URL',
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
                                  SizedBox(height: 20.h),
                                  FFButtonWidget(
                                    showLoadingIndicator: true,
                                    loading: isCreatePageLoading,
                                    onPressed: () async {
                                      try {
                                        final api = getIt<Api>();

                                        setState(() {
                                          isCreatePageLoading = true;
                                        });
                                        final response = await api.post('page', formObj: {
                                          'url': _pageController.text,
                                        });
                                        setState(() {
                                          isCreatePageLoading = false;
                                        });

                                        final model = BaseModel.fromJson(response.data);

                                        if (model.success ?? false) {
                                          Navigator.pop(context);
                                          _pageController.clear();
                                          fetchPage();
                                        } else {}
                                      } catch (err) {}
                                    },
                                    text: 'Tambahkan',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                      height: 50.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: const Color(0xFFCD7F32),
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
                backgroundColor: const Color(0xFF995F25),
                child: const Icon(Icons.add),
              ),
            )
          : null,
    );
  }
}
