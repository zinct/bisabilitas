///
/// bookmark_screen.dart
/// lib/features/main/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/components/progressindicator/primary_progress_indicator.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/core/models/list/list_model.dart';
import 'package:bisabilitas/core/widgets/touchable_opacity_widget.dart';
import 'package:bisabilitas/features/page/domain/entities/page/page_entity.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookmarkScreen extends StatelessWidget {
  final bool isLoading;
  final List<PageEntity> pages;
  final RefreshCallback onRefresh;

  const BookmarkScreen({
    super.key,
    required this.onRefresh,
    required this.isLoading,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: isLoading
          ? const Center(
              child: PrimaryProgressIndicator(),
            )
          : Container(
              height: MediaQuery.sizeOf(context).height,
              child: RefreshIndicator(
                color: const Color(0xFF995F25),
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 20.0, 24.0, 0.0),
                          child: Text(
                            'Tersimpan',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 20.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Text(
                                'Terakhir tersimpan',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...pages.map((row) => Column(
                            children: [
                              SizedBox(height: 20.h),
                              TouchableOpacityWidget(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ROUTER.pageDetail,
                                      arguments: row.url);
                                },
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 12.0, 0.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      height: 146.0.h,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(14.0, 14.0, 14.0, 14.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.0),
                                                    child: Image.network(
                                                      row.image!,
                                                      width: 90.0,
                                                      height: 90.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        row.title!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Inter',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        row.url!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Inter',
                                                          color: const Color(
                                                              0xFFCFCFCF),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        row.description!,
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Inter',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        'Selengkapnya',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Inter',
                                                          color: const Color(
                                                              0xFF995F25),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              2.0, 0.0, 0.0),
                                                      child: Text(
                                                        DateFormat(
                                                                'EEE, dd-MM-yyyy')
                                                            .format(
                                                                row.createdAt!),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Inter',
                                                          color: const Color(
                                                              0xFFCFCFCF),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/heart.png',
                                                              width: 15.0,
                                                              height: 15.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
