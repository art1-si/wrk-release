import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/app.dart';
import 'package:flutter/rendering.dart';

import 'package:workout_notes_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  debugPaintSizeEnabled = false;
  runApp(
    ProviderScope(
      child: AppTheme(
        data: Themes.theme,
        child: MyApp(),
      ),
    ),
  );
}
