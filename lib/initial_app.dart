import 'dart:io';

import 'package:bisabilitas/core/https/http_client_overrides.dart';
import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.dart' as di;

class InitialApp {
  static Future<void> execute() async {
    await _initWidget();
    _initDependencyInjection();
    await _initIntl();
    await _initHive();
    _initHttp();
  }

  static Future<void> _initialSupabase() async {
    await Supabase.initialize(
      url: 'https://komaerccowqpavzofzlc.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvbWFlcmNjb3dxcGF2em9memxjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY2MDYzMDcsImV4cCI6MjAzMjE4MjMwN30.G2e4ld4gy2DgUZfVOXr9h4sAjWsoc2X7XmP3IsPEoXE',
    );
  }

  static void _initDependencyInjection() {
    di.initialize();
  }

  static void _initHttp() {
    HttpOverrides.global = MyHttpOverrides();
  }

  static Future<void> _initWidget() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    await FlutterFlowTheme.initialize();
  }

  static Future<void> _initHive() async {
    return Hive.initFlutter();
  }

  static Future<void> _initIntl() {
    return initializeDateFormatting('id_ID', null);
  }
}
