// main.dart

import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced_getit/reduced_getit.dart';

import 'widgets.dart';

void main() {
  registerState(MyAppState(title: 'reduced_getit example'));
  runApp(const MyApp());
}
