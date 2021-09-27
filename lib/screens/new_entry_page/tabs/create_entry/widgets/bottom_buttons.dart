import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class RowWithBottomButtons extends ConsumerWidget {
  const RowWithBottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _createEntry = watch(createNewEntryProvider);
    final _theme = AppTheme.of(context);
    final submitColor = _createEntry.editModeActive
        ? _theme.accentSecendery
        : _theme.accentPrimary;
    final resetColor = _theme.accentNegative;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedHomePageButton(
            onPress: _createEntry.handleOnTapSubmitEditButton,
            title: _createEntry.editModeActive ? "Edit" : "Submit",
            backgroundColor: submitColor.withOpacity(0.05),
            titleColor: submitColor,
          ),
          ElevatedHomePageButton(
            disable: !_createEntry.editModeActive,
            onPress: _createEntry.handleOnTapDeleteOrReset,
            title: "Delete",
            backgroundColor: resetColor.withOpacity(0.05),
            titleColor: resetColor.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
