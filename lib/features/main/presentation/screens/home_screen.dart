///
/// home_screen.dart
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
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRecommendationLoading = false;
  bool isHistoryLoading = false;
  List<PageEntity> recommendationPages = [];
  List<PageEntity> historyPages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRecommendationPage();
    fetchHistoryPage();
  }

  void fetchHistoryPage() async {
    setState(() {
      isHistoryLoading = true;
    });
    final response = await getIt<Api>().get('page-history');
    setState(() {
      isHistoryLoading = false;
    });

    final model = ListModel.fromJson(response.data, (p0) => PageEntity.fromJson(p0));
    if (model.success ?? false) {
      setState(() {
        historyPages = model.data!;
      });
    }
  }

  void fetchRecommendationPage() async {
    setState(() {
      isRecommendationLoading = true;
    });
    final response = await getIt<Api>().get('page-recommendation');
    setState(() {
      isRecommendationLoading = false;
    });

    final model = ListModel.fromJson(response.data, (p0) => PageEntity.fromJson(p0));
    if (model.success ?? false) {
      setState(() {
        recommendationPages = model.data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      child: isRecommendationLoading || isHistoryLoading
          ? const Center(
              child: PrimaryProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                fetchHistoryPage();
                fetchRecommendationPage();
                return Future.delayed(Duration.zero);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 0.0),
                        child: Text(
                          'Beranda',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    ),
                    historyPages.isNotEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Terakhir Dibaca',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            'Lihat',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.getFont(
                                              'Inter',
                                              color: const Color(0xFFBFA100),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/chevron-right.png',
                                              width: 14.0,
                                              height: 14.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 1),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ...historyPages
                                            .map(
                                              (row) => Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0, 0.0),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  child: Container(
                                                    width: 323.0.w,
                                                    height: 146.0.h,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(14.0, 14.0, 14.0, 14.0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(9.0),
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
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      row.title!,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.start,
                                                                      style: GoogleFonts.getFont(
                                                                        'Inter',
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 14.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      row.url!,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.start,
                                                                      style: GoogleFonts.getFont(
                                                                        'Inter',
                                                                        color: const Color(0xFFCFCFCF),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 12.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      row.description!,
                                                                      textAlign: TextAlign.start,
                                                                      maxLines: 2,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: GoogleFonts.getFont(
                                                                        'Inter',
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 13.0,
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5.h),
                                                                    Text(
                                                                      'Selengkapnya',
                                                                      textAlign: TextAlign.start,
                                                                      style: GoogleFonts.getFont(
                                                                        'Inter',
                                                                        color: const Color(0xFF995F25),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 13.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Align(
                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                  child: Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                    child: Text(
                                                                      DateFormat('EEE, dd-MM-yyyy').format(row.createdAt!),
                                                                      textAlign: TextAlign.start,
                                                                      style: GoogleFonts.getFont(
                                                                        'Inter',
                                                                        color: const Color(0xFFCFCFCF),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 12.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8.0),
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
                                            )
                                            .toList(),
                                        SizedBox(width: 24.w),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, historyPages.isNotEmpty ? 40.0 : 20.0, 24.0, 0.0),
                        child: Text(
                          'Rekomendasi Topik\nHari ini',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              'Berdasarkan preferensi topik pilihan anda',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TouchableOpacityWidget(
                      onTap: () {
                        Navigator.of(context).pushNamed(ROUTER.pageDetail, arguments: recommendationPages[0].url);
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 290.h,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    recommendationPages[0].image!,
                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                    height: 170.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                recommendationPages[0].title!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              Text(
                                                recommendationPages[0].url!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  color: const Color(0xFFCFCFCF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              Text(
                                                recommendationPages[0].description!,
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(0.0, 0.0),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Sel - 20.20',
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.getFont(
                                                      'Inter',
                                                      color: const Color(0xFFCFCFCF),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8.0),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...recommendationPages
                                  .sublist(1)
                                  .map(
                                    (row) => TouchableOpacityWidget(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(ROUTER.pageDetail, arguments: row.url);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Container(
                                            width: 323.0.w,
                                            height: 146.0.h,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(14.0, 14.0, 14.0, 14.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(9.0),
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
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              row.title!,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.start,
                                                              style: GoogleFonts.getFont(
                                                                'Inter',
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              row.url!,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.start,
                                                              style: GoogleFonts.getFont(
                                                                'Inter',
                                                                color: const Color(0xFFCFCFCF),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              row.description!,
                                                              textAlign: TextAlign.start,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.getFont(
                                                                'Inter',
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 13.0,
                                                              ),
                                                            ),
                                                            SizedBox(height: 5.h),
                                                            Text(
                                                              'Selengkapnya',
                                                              textAlign: TextAlign.start,
                                                              style: GoogleFonts.getFont(
                                                                'Inter',
                                                                color: const Color(0xFF995F25),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 13.0,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              SizedBox(width: 24.w),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
