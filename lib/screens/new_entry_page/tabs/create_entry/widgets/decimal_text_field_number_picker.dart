import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/base_tf_num_picker.dart';

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
  // late double? inputValue = widget.initValue;

  @override
  Widget build(BuildContext context) {
    //TODO: make signle textfield
    _controller = TextEditingController(text: widget.initValue.toString());

    double _tfWidth = widget.initValue.toInt().toString().length.toDouble() < 3
        ? 3 * 45
        : widget.initValue.toInt().toString().length.toDouble() * 45;
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
          widget.onChange(value.isEmpty ? 0.0 : double.parse(value));
        },
      ),
      onPressedLeftArow: () {
        if (widget.initValue > 0) {
          widget.onChange(widget.initValue - widget.changesByValue);
        }
      },
      onPressedRightArow: () {
        widget.onChange(widget.initValue + widget.changesByValue);
      },
      leftSubText: "${widget.initValue - widget.changesByValue}",
      rightSubText: "${widget.initValue + widget.changesByValue}",
      reachedZero: widget.initValue > 0,
    );
  }
}
