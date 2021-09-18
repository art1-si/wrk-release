import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class RowWithBottomButtons extends StatelessWidget {
  const RowWithBottomButtons({
    Key? key,
    required this.submitButtonPressed,
    required this.resetOrDeleteButtonPressed,
    required this.editModeOn,
  }) : super(key: key);

  final VoidCallback submitButtonPressed;
  final VoidCallback resetOrDeleteButtonPressed;
  final bool editModeOn;

  @override
  Widget build(BuildContext context) {
    final _theme = AppTheme.of(context);
    final submitColor =
        editModeOn ? _theme.accentSecendery : _theme.accentPrimary;
    final resetColor =
        editModeOn ? _theme.accentNegative : _theme.accentPositive;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedHomePageButton(
            onPress: submitButtonPressed,
            title: editModeOn ? "Edit" : "Submit",
            backgroundColor: submitColor.withOpacity(0.05),
            titleColor: submitColor,
          ),
          ElevatedHomePageButton(
            onPress: resetOrDeleteButtonPressed,
            title: editModeOn ? "Delete" : "Reset",
            backgroundColor: resetColor.withOpacity(0.05),
            titleColor: resetColor.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
