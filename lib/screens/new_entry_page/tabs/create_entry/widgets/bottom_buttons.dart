import 'package:flutter/material.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RowWithBottomButtons extends StatelessWidget {
  const RowWithBottomButtons({
    Key? key,
    required this.submitButtonPressed,
    required this.resetOrDeleteButtonPressed,
  }) : super(key: key);

  final VoidCallback submitButtonPressed;
  final VoidCallback resetOrDeleteButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedHomePageButton(
            onPress: submitButtonPressed,
            title: "Submit",
            backgroundColor:
                AppTheme.of(context).accentPrimary.withOpacity(0.05),
            titleColor: AppTheme.of(context).accentPrimary,
          ),
          ElevatedHomePageButton(
            onPress: resetOrDeleteButtonPressed,
            title: "Reset",
            backgroundColor:
                AppTheme.of(context).accentPositive.withOpacity(0.05),
            titleColor: AppTheme.of(context).accentPositive.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
