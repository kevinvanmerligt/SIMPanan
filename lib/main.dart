import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // Mengaktifkan mode layar refresh rate tertinggi (60Hz, 90Hz, 120Hz, 144Hz)
  if (Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      debugPrint('Info: FlutterDisplayMode setHighRefreshRate not supported: $e');
    }
  }

  runApp(const DompetHarianApp());
}
