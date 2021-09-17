import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/base_tf_num_picker.dart';

class DecimalTextFieldNumPicker extends StatefulWidget {
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
  State<DecimalTextFieldNumPicker> createState() =>
      _DecimalTextFieldNumPickerState();
}

class _DecimalTextFieldNumPickerState extends State<DecimalTextFieldNumPicker> {
  TextEditingController? _controller;
  double? inputValue;

//TODO: clean-up everything in here
  @override
  void initState() {
    inputValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: make signle textfield
    _controller = TextEditingController(text: inputValue.toString());
    double _tfWidth = inputValue!.toInt().toString().length.toDouble() < 3
        ? 3 * 45
        : inputValue!.toInt().toString().length.toDouble() * 45;
    return BaseTFNumPicker(
      width: _tfWidth,
      title: widget.title,
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
          fontSize: 42.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
        textAlign: TextAlign.center,
        controller: _controller,
        onChanged: (value) {
          inputValue = value.isEmpty ? 0.0 : double.parse(value);
          widget.onChange(inputValue!);
        },
      ),
      onPressedLeftArow: () {
        if (inputValue! > 0) {
          setState(() {
            inputValue = inputValue! - widget.changesByValue;
            widget.onChange(inputValue!);
          });
        }
      },
      onPressedRightArow: () {
        setState(() {
          inputValue = inputValue! + widget.changesByValue;
          widget.onChange(inputValue!);
        });
      },
      leftSubText: "${inputValue! - widget.changesByValue}",
      rightSubText: "${inputValue! + widget.changesByValue}",
      reachedZero: inputValue! > 0,
    );
  }
}
