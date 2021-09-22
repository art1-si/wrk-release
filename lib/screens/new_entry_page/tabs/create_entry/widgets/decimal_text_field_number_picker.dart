import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/base_tf_num_picker.dart';

final decimalTextController =
    Provider.autoDispose<TextEditingController>((ref) {
  final _weight = ref.watch(createNewEntryProvider); //TODO: use select
  final controller = TextEditingController(text: _weight.weight.toString());

  /* ref.onDispose(() {
    controller.dispose();
  }); */
//TODO: dispose
  return controller;
});

class DecimalTextFieldNumPicker extends ConsumerWidget {
  const DecimalTextFieldNumPicker({
    Key? key,
    required this.title,
    required this.initValue,
    required this.onChange,
    required this.changesByValue,
  }) : super(key: key);

  final String title;
  final double initValue;
  final ValueChanged<double> onChange;
  final double changesByValue;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double _tfWidth = initValue.toString().length.toDouble() < 3
        ? 3 * 45
        : (initValue.toString().length.toDouble() - 1) * 36;
    return BaseTFNumPicker(
      width: _tfWidth,
      title: title,
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Please enter value";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 36.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
        textAlign: TextAlign.center,
        controller: watch(decimalTextController),
        onChanged: (value) {
          var inputValue = value.isEmpty ? 0.0 : double.parse(value);
          context.read(createNewEntryProvider).weightSetter(inputValue);
        },
      ),
      onPressedLeftArow: () {
        if (initValue > 0) {
          var inputValue = initValue - changesByValue;
          onChange(inputValue);
        }
      },
      onPressedRightArow: () {
        var inputValue = initValue + changesByValue;
        onChange(inputValue);
      },
      leftSubText: "${initValue - changesByValue}",
      rightSubText: "${initValue + changesByValue}",
      reachedZero: initValue > 0,
    );
  }
}
