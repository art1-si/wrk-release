import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/decimal_text_field_number_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/text_field_number_picker.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class CreateNewEntry extends StatelessWidget {
  const CreateNewEntry({
    Key? key,
    required this.onWeightValueChanged,
    required this.onRepsValueChanged,
    required this.weightInitValue,
    required this.repsInitValue,
    required this.bottomButtons,
  }) : super(key: key);

  final ValueChanged<double> onWeightValueChanged;
  final ValueChanged<int> onRepsValueChanged;
  final double weightInitValue;
  final int repsInitValue;
  final Widget bottomButtons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecimalTextFieldNumPicker(
          title: "WEIGHT",
          initValue: weightInitValue,
          onChange: onWeightValueChanged,
          changesByValue: 2.5,
        ),
        TextFieldNumerPicker(
          title: "Reps",
          initValue: repsInitValue,
          onChange: onRepsValueChanged,
          changesByValue: 1,
        ),
        bottomButtons,
      ],
    );
  }
}
