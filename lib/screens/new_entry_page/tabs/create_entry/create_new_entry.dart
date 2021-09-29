import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/decimal_text_field_number_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/rpe_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/text_field_number_picker.dart';

class CreateNewEntry extends ConsumerWidget {
  const CreateNewEntry({
    Key? key,
    required this.bottomButtons,
  }) : super(key: key);

  final Widget bottomButtons;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _createNewEntry = watch(createNewEntryProvider);

    return Column(
      children: <Widget>[
        DecimalTextFieldNumPicker(
          title: "WEIGHT",
          initValue: _createNewEntry.weight,
          onChange: _createNewEntry.setWeightWithNewValue,
          changesByValue: 2.5,
        ),
        TextFieldNumerPicker(
          title: "Reps",
          initValue: _createNewEntry.reps,
          onChange: _createNewEntry.setRepsWithNewValue,
          changesByValue: 1,
        ),
        RPEPicker(
          value: _createNewEntry.rpe,
          onChanged: _createNewEntry.setRPEWithNewValue,
        ),
        bottomButtons,
      ],
    );
  }
}
