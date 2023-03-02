// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_getit/reduced_getit.dart';
import 'logic.dart';

void main() {
  registerState(initialState: 0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Builder(
          builder: (context) => wrapWithConsumer(
            transformer: transformer,
            builder: builder,
          ),
        ),
      );
}
