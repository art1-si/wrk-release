import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/app.dart';
import 'package:flutter/rendering.dart';

void main() async {
  debugPaintSizeEnabled = false;
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
