import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_ddd/firebase_options.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/presentation/core/app_widget.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ru');
  runApp(AppWidget());
}
