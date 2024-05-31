import 'package:bloc/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/injection.dart';
import 'package:bloc/presentation/app_widget.dart';

import 'presentation/app_widget.dart';
import 'package:injectable/injectable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjection(Environment.prod);
  runApp(AppWidget());
}
