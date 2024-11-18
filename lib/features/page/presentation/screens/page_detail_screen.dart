///
/// page_detail_screen.dart
/// lib/features/page/presentation/screens
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:bisabilitas/core/api/api.dart';
import 'package:bisabilitas/core/models/base/base_model.dart';
import 'package:bisabilitas/core/widgets/touchable_opacity_widget.dart';
import 'package:bisabilitas/core/widgets/webview_widget.dart';
import 'package:bisabilitas/features/page/service/page_service.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_widgets.dart';
import 'package:bisabilitas/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PageDetailScreen extends StatefulWidget {
  const PageDetailScreen({super.key});

  @override
  State<PageDetailScreen> createState() => _PageDetailScreenState();
}

enum ProfileAccessibility { none, blind, lowVision, colorBlind, dyslexia, epilepsy, adhd }

class _PageDetailScreenState extends State<PageDetailScreen> {
  int font = 0;
  int saturation = 0;
  int lineSpacing = 0;
  int letterSpacing = 0;
  int textAlign = 0;
  bool isOpenDyslexic = false;
  bool invertColor = false;
  bool caption = false;
  bool blockImage = false;
  bool focus = false;
  bool readingMode = false;
  bool isNavigationSound = false;

  int profil = 0;
  ProfileAccessibility profileAccessibility = ProfileAccessibility.none;
  String? dictionaryText;
  bool isDictionaryLoading = false;
  TextEditingController dictionaryController = TextEditingController();

  // Speech
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = true;
  String _lastWords = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _stopListening() async {
    print("STOP");
    await _speechToText.stop();
    setState(() {
      isNavigationSound = false;
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      isNavigationSound = true;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      if (result.recognizedWords.isNotEmpty) {
        if (int.tryParse(result.recognizedWords) != null) {
          PageService().removeNumbersFromElements(_webViewController!);
          PageService().navigateWithNumber(_webViewController!, int.parse(result.recognizedWords));
          isNavigationSound = false;
        } else {
          _startListening();
        }
      } else {
        _startListening();
      }
    });
  }
  // End Of Speech

  late InAppWebViewController? _webViewController;

  String getProfilLabel() {
    switch (profileAccessibility) {
      case ProfileAccessibility.none:
        return "Default";
      case ProfileAccessibility.blind:
        return "Buta Total / Parsial";
      case ProfileAccessibility.colorBlind:
        return "Penglihatan Kurang";
      case ProfileAccessibility.dyslexia:
        return "Disleksia";
      case ProfileAccessibility.epilepsy:
        return "Epilepsi";
      case ProfileAccessibility.adhd:
        return "ADHD";
      default:
        return "-";
    }
  }

  String getSaturationLabel() {
    switch (saturation) {
      case 0:
        return "Saturasi Normal";
      case 1:
        return "Saturasi Sedang";
      case 2:
        return "Saturasi Tinggi";
      case 3:
        return "Desaturasi";
      default:
        return "Saturasi Normal";
    }
  }

  String getLineSpacingLabel() {
    switch (lineSpacing) {
      case 0:
        return "Default";
      case 1:
        return "Sedang";
      case 2:
        return "Tinggi";
      default:
        return "Default";
    }
  }

  String getLetterSpacing() {
    switch (letterSpacing) {
      case 0:
        return "Default";
      case 1:
        return "Sedang";
      case 2:
        return "Tinggi";
      default:
        return "Default";
    }
  }

  String getFontLabel() {
    switch (font) {
      case 0:
        return "Default";
      case 1:
        return "Sedang";
      case 2:
        return "Tinggi";
      default:
        return "Default";
    }
  }

  String getTextAlignLabel() {
    switch (textAlign) {
      case 0:
        return "Default";
      case 1:
        return "Kiri";
      case 2:
        return "Tengah";
      case 3:
        return "Kanan";
      default:
        return "Default";
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                onConsoleMessage: (p0, p1) {
                  print("CONSOLE WEB: ${p1.message}");
                },
                initialURI: Uri.parse(url),
                onLoadStart: (controller, url) {
                  print('object');
                  _webViewController = controller;
                },
                onLoadStop: (p0, p1) {
                  print('object');
                  if (_webViewController != null) {
                    PageService().initializeFontSize(_webViewController!);
                    // PageService().initializeOpenDyslexicFont(_webViewController!);
                    PageService().initialCaption(_webViewController!);
                  }
                },
              ),
            ),
            Container(
              height: 133.h,
              width: MediaQuery.of(context).size.height,
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
              child: Column(
                children: [
                  TouchableOpacityWidget(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            height: 400.h,
                            child: SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h),
                                  Text(
                                    'Profil Aksesibilitas',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF303030),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                        ),
                                  ),
                                  SizedBox(height: 20.h),
                                  ProfileAccessibilityOption(
                                    imagePath: 'assets/images/asisten.png',
                                    onChanged: (ProfileAccessibility? value) {
                                      setState(() {
                                        profileAccessibility = value!;
                                        if (focus == true) {
                                          focus = false;
                                          PageService().toggleSpotFocus(_webViewController!);
                                        }
                                        if (font == 2) {
                                          font = 0;
                                          PageService().toggleFontSize(_webViewController!);
                                          PageService().toggleFontSize(_webViewController!);
                                        }
                                        if (isOpenDyslexic == true) {
                                          isOpenDyslexic = false;
                                          PageService().toggleOpenDyslexicFont(_webViewController!);
                                        }
                                      });
                                    },
                                    groupValue: profileAccessibility,
                                    label: "Default",
                                    value: ProfileAccessibility.none,
                                  ),
                                  ProfileAccessibilityOption(
                                    imagePath: 'assets/images/penglihatan.png',
                                    onChanged: (ProfileAccessibility? value) {
                                      setState(() {
                                        profileAccessibility = value!;
                                        if (font != 2) {
                                          font = 2;
                                          PageService().toggleFontSize(_webViewController!);
                                          PageService().toggleFontSize(_webViewController!);
                                        }
                                      });
                                    },
                                    groupValue: profileAccessibility,
                                    label: "Penglihatan Kurang",
                                    value: ProfileAccessibility.colorBlind,
                                  ),
                                  ProfileAccessibilityOption(
                                    imagePath: 'assets/images/disleksia.png',
                                    onChanged: (ProfileAccessibility? value) {
                                      setState(() {
                                        profileAccessibility = value!;
                                        if (isOpenDyslexic == false) {
                                          isOpenDyslexic = true;
                                          PageService().toggleOpenDyslexicFont(_webViewController!);
                                        }
                                      });
                                    },
                                    groupValue: profileAccessibility,
                                    label: "Disleksia",
                                    value: ProfileAccessibility.dyslexia,
                                  ),
                                  ProfileAccessibilityOption(
                                    imagePath: 'assets/images/epilepsi.png',
                                    onChanged: (ProfileAccessibility? value) {
                                      setState(() {
                                        profileAccessibility = value!;
                                        if (saturation != 3) {
                                          saturation = 3;
                                          PageService().toggleSaturation(_webViewController!);
                                          PageService().toggleSaturation(_webViewController!);
                                          PageService().toggleSaturation(_webViewController!);
                                        }
                                      });
                                    },
                                    groupValue: profileAccessibility,
                                    label: "Epilepsi",
                                    value: ProfileAccessibility.epilepsy,
                                  ),
                                  ProfileAccessibilityOption(
                                    imagePath: 'assets/images/adhd.png',
                                    onChanged: (ProfileAccessibility? value) {
                                      setState(() {
                                        profileAccessibility = value!;
                                        if (focus == false) {
                                          focus = true;
                                          PageService().toggleSpotFocus(_webViewController!);
                                        }
                                      });
                                    },
                                    groupValue: profileAccessibility,
                                    label: "ADHD",
                                    value: ProfileAccessibility.adhd,
                                  ),
                                  SizedBox(height: 40.h),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    child: isNavigationSound
                        ? Container(
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Center(
                              child: Text(
                                '🎙️ Bisabilitas mendengarkan...',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                    ),
                              ),
                            ),
                          )
                        : Container(
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0XFFCD7F32),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Center(
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'Profil Aksesibilitas : ${getProfilLabel()}',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                        ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TouchableOpacityWidget(
                              onTap: () {
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
                                          height: 400.h,
                                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                                          color: Colors.white,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(height: 20),
                                                Text(
                                                  'Kamus Bahasa',
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.getFont(
                                                    'Inter',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                dictionaryText == null ? Spacer() : Container(),
                                                SizedBox(height: 15.h),
                                                dictionaryText == null
                                                    ? Container()
                                                    : Flexible(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Hasil : ",
                                                              style: GoogleFonts.getFont('Inter', fontSize: 13.0, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              "$dictionaryText",
                                                              style: GoogleFonts.getFont(
                                                                'Inter',
                                                                fontSize: 13.0,
                                                                color: Color(0xFFCD7F32),
                                                              ),
                                                              maxLines: null, // Allows the text to wrap to next lines
                                                              overflow: TextOverflow.visible, // Ensures text is visible when wrapped
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                TextFormField(
                                                  controller: dictionaryController,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Kalimat / Kata',
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
                                                SizedBox(height: 30),
                                                FFButtonWidget(
                                                  showLoadingIndicator: true,
                                                  loading: isDictionaryLoading,
                                                  onPressed: () async {
                                                    try {
                                                      final api = getIt<Api>();

                                                      setState(() {
                                                        isDictionaryLoading = true;
                                                      });
                                                      final response = await api.post('kbbi', formObj: {
                                                        'text': dictionaryController.text,
                                                      });
                                                      setState(() {
                                                        isDictionaryLoading = false;
                                                      });

                                                      final model = BaseModel.fromJson(response.data);

                                                      if (model.success ?? false) {
                                                        setState(() {
                                                          dictionaryText = model.data['text'];
                                                          print(dictionaryText);
                                                        });
                                                      } else {}
                                                    } catch (err) {}
                                                  },
                                                  text: 'Tanyakan',
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
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Icon(
                                      Icons.menu_book_outlined,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Kamus Bahasa',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF020617),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TouchableOpacityWidget(
                              onTap: () {
                                if (_webViewController != null) {
                                  setState(() {
                                    PageService().toggleFontSize(_webViewController!);
                                    font = (font + 1) % 3;
                                  });
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/font.png',
                                        width: 26.w,
                                        height: 26.w,
                                      )),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Font ${getFontLabel()}',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF020617),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TouchableOpacityWidget(
                              onTap: () {
                                if (_speechToText.isNotListening) {
                                  if (!isNavigationSound) {
                                    PageService().addNumberToElement(_webViewController!);
                                  }
                                  _startListening();
                                } else {
                                  PageService().removeNumbersFromElements(_webViewController!);
                                  setState(() {
                                    _lastWords = "";
                                  });
                                  _stopListening();
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Icon(!isNavigationSound ? Icons.mic_off : Icons.mic),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Navigasi Suara',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF020617),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TouchableOpacityWidget(
                              onTap: () {
                                setState(() {
                                  if (_webViewController != null) {
                                    setState(() {
                                      PageService().toggleSaturation(_webViewController!);
                                      saturation = (saturation + 1) % 4;
                                    });
                                  }
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/saturasi.png',
                                        width: 26.w,
                                        height: 26.w,
                                      )),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      getSaturationLabel(),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF020617),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TouchableOpacityWidget(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                    return SizedBox(
                                      height: 250.h,
                                      child: SingleChildScrollView(
                                        controller: ModalScrollController.of(context),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15.h),
                                            Text(
                                              'Fitur Lain',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFF303030),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                  ),
                                            ),
                                            SizedBox(height: 20.h),
                                            ListTile(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                showMaterialModalBottomSheet(
                                                  context: context,
                                                  builder: (context) => StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return SizedBox(
                                                        height: 380.h,
                                                        child: SingleChildScrollView(
                                                          controller: ModalScrollController.of(context),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 15.h),
                                                              Text(
                                                                'Pengaturan Konten',
                                                                textAlign: TextAlign.center,
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Inter',
                                                                      color: Color(0xFF303030),
                                                                      fontSize: 18.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                    ),
                                                              ),
                                                              SizedBox(height: 20),
                                                              ListTile(
                                                                title: Text(
                                                                  'Font Ramah Disleksia',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Switch(
                                                                  value: isOpenDyslexic,
                                                                  activeColor: Color(0xFFCD7F32),
                                                                  inactiveThumbColor: Color(0xFFCD7F32),
                                                                  onChanged: (bool value) {
                                                                    setState(() {
                                                                      PageService().toggleOpenDyslexicFont(_webViewController!);
                                                                      isOpenDyslexic = value;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (_webViewController != null) {
                                                                      setState(() {
                                                                        PageService().toggleLetterSpacing(_webViewController!);
                                                                        letterSpacing = (letterSpacing + 1) % 3;
                                                                      });
                                                                    }
                                                                  });
                                                                },
                                                                title: Text(
                                                                  'Jarak Spasi',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Text(
                                                                  getLetterSpacing(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Color(0xFFCD7F32),
                                                                        fontSize: 14.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (_webViewController != null) {
                                                                      setState(() {
                                                                        PageService().toggleLineSpacing(_webViewController!);
                                                                        lineSpacing = (lineSpacing + 1) % 3;
                                                                      });
                                                                    }
                                                                  });
                                                                },
                                                                title: Text(
                                                                  'Jarak Baris',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Text(
                                                                  getLineSpacingLabel(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Color(0xFFCD7F32),
                                                                        fontSize: 14.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  if (_webViewController != null) {
                                                                    setState(() {
                                                                      PageService().toggleFontSize(_webViewController!);
                                                                      font = (font + 1) % 3;
                                                                    });
                                                                  }
                                                                },
                                                                title: Text(
                                                                  'Ukuran Teks',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Text(
                                                                  getFontLabel(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Color(0xFFCD7F32),
                                                                        fontSize: 14.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  if (_webViewController != null) {
                                                                    setState(() {
                                                                      PageService().toggleTextAlign(_webViewController!);
                                                                      textAlign = (textAlign + 1) % 4;
                                                                    });
                                                                  }
                                                                },
                                                                title: Text(
                                                                  'Ratakan Teks',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Text(
                                                                  getTextAlignLabel(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Color(0xFFCD7F32),
                                                                        fontSize: 14.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              title: Text(
                                                "Pengaturan Konten",
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Inter',
                                                      color: Color(0xFF303030),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                    ),
                                              ),
                                              trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Navigator.of(context).pop();

                                                showMaterialModalBottomSheet(
                                                  context: context,
                                                  builder: (context) => StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return SizedBox(
                                                        height: 200.h,
                                                        child: SingleChildScrollView(
                                                          controller: ModalScrollController.of(context),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 15.h),
                                                              Text(
                                                                'Pengaturan Warna',
                                                                textAlign: TextAlign.center,
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Inter',
                                                                      color: Color(0xFF303030),
                                                                      fontSize: 18.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                    ),
                                                              ),
                                                              SizedBox(height: 20),
                                                              ListTile(
                                                                title: Text(
                                                                  'Inversi Warna',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Switch(
                                                                  value: invertColor,
                                                                  activeColor: Color(0xFFCD7F32),
                                                                  inactiveThumbColor: Color(0xFFCD7F32),
                                                                  onChanged: (bool value) {
                                                                    setState(() {
                                                                      if (_webViewController != null) {
                                                                        setState(() {
                                                                          PageService().toggleInvertColor(_webViewController!);
                                                                          invertColor = !invertColor;
                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (_webViewController != null) {
                                                                      setState(() {
                                                                        PageService().toggleSaturation(_webViewController!);
                                                                        saturation = (saturation + 1) % 4;
                                                                      });
                                                                    }
                                                                  });
                                                                },
                                                                title: Text(
                                                                  'Saturasi',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Text(
                                                                  getSaturationLabel(),
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Color(0xFFCD7F32),
                                                                        fontSize: 14.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              title: Text(
                                                "Pengaturan Warna",
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Inter',
                                                      color: Color(0xFF303030),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                    ),
                                              ),
                                              trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                showMaterialModalBottomSheet(
                                                  context: context,
                                                  builder: (context) => StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return SizedBox(
                                                        height: 250.h,
                                                        child: SingleChildScrollView(
                                                          controller: ModalScrollController.of(context),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 15.h),
                                                              Text(
                                                                'Pengaturan Lainnya',
                                                                textAlign: TextAlign.center,
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Inter',
                                                                      color: Color(0xFF303030),
                                                                      fontSize: 18.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                    ),
                                                              ),
                                                              SizedBox(height: 20),
                                                              ListTile(
                                                                title: Text(
                                                                  'Caption',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Switch(
                                                                  value: caption,
                                                                  activeColor: Color(0xFFCD7F32),
                                                                  inactiveThumbColor: Color(0xFFCD7F32),
                                                                  onChanged: (bool value) {
                                                                    setState(() {
                                                                      if (_webViewController != null) {
                                                                        setState(() {
                                                                          PageService().toggleCaption(_webViewController!);
                                                                          caption = !caption;
                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Sembunyikan Gambar',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Switch(
                                                                  value: blockImage,
                                                                  activeColor: Color(0xFFCD7F32),
                                                                  inactiveThumbColor: Color(0xFFCD7F32),
                                                                  onChanged: (bool value) {
                                                                    setState(() {
                                                                      if (_webViewController != null) {
                                                                        setState(() {
                                                                          PageService().toggleBlockImage(_webViewController!);
                                                                          blockImage = !blockImage;
                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Spot Fokus',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Inter',
                                                                        color: Colors.black,
                                                                        fontSize: 16.0,
                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                                      ),
                                                                ),
                                                                trailing: Switch(
                                                                  value: focus,
                                                                  activeColor: Color(0xFFCD7F32),
                                                                  inactiveThumbColor: Color(0xFFCD7F32),
                                                                  onChanged: (bool value) {
                                                                    setState(() {
                                                                      if (_webViewController != null) {
                                                                        setState(() {
                                                                          PageService().toggleSpotFocus(_webViewController!);
                                                                          focus = !focus;
                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              title: Text(
                                                "Lainnya",
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Inter',
                                                      color: Color(0xFF303030),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                                    ),
                                              ),
                                              trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/fitur-lain.png',
                                        width: 26.w,
                                        height: 26.w,
                                      )),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Fitur Lain',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF020617),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                                          ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAccessibilityOption extends StatelessWidget {
  const ProfileAccessibilityOption({
    super.key,
    required this.onChanged,
    required this.groupValue,
    required this.label,
    required this.value,
    required this.imagePath,
  });

  final void Function(ProfileAccessibility?)? onChanged;
  final ProfileAccessibility? groupValue;
  final ProfileAccessibility value;
  final String label;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 26.w,
        height: 26.w,
      ),
      onTap: () {
        onChanged!(value);
      },
      title: Text(
        label,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Inter',
              color: Color(0xFF303030),
              fontSize: 14.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
            ),
      ),
      trailing: Transform.scale(
        scale: 1.2,
        child: Radio<ProfileAccessibility>(
          value: value,
          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFFCD7F32).withOpacity(.32);
            }
            return Color(0xFFCD7F32);
          }),
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
