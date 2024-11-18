///
/// account_screen.dart
/// lib/features/main/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/constants/hive.dart';
import 'package:bisabilitas/core/constants/router.dart';
import 'package:bisabilitas/core/widgets/touchable_opacity_widget.dart';
import 'package:bisabilitas/features/account/domain/entities/profile/profile_entity.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class AccountScreen extends StatelessWidget {
  final ProfileEntity? profile;

  const AccountScreen({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Pengaturan',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFF3F3F3),
                        blurRadius: 2,
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        profile?.image ?? "https://cdn-icons-png.flaticon.com/512/219/219983.png",
                        width: 54,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.name ?? "Indra Mahesa",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              profile?.email ?? "indramahesa128@gmail.com",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: Color(0xFF909090),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Akun',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFF3F3F3),
                        blurRadius: 2,
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(ROUTER.profile, arguments: profile);
                        },
                        title: Text(
                          'Manajemen Akun',
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.05),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Logout',
                          style: GoogleFonts.getFont('Inter', fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.red),
                        ),
                        onTap: () async {
                          final box = await Hive.openBox(HIVE.databaseName);
                          box.put(HIVE.tokenData, "");
                          Navigator.of(context).pushReplacementNamed(ROUTER.onboarding);
                        },
                        trailing: Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ) ??
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(ROUTER.onboarding);
          },
          child: Container(),
        );
  }
}
