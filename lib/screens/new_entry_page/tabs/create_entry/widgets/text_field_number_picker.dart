import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/base_tf_num_picker.dart';

class TextFieldNumerPicker extends StatefulWidget {
  const TextFieldNumerPicker({
    Key? key,
    required this.title,
    required this.initValue,
    required this.onChange,
    required this.changesByValue,
  }) : super(key: key);

  final String title;
  final int initValue;
  final ValueChanged<int> onChange;
  final int changesByValue;

  @override
  _TextFieldNumerPickerState createState() => _TextFieldNumerPickerState();
}

class _TextFieldNumerPickerState extends State<TextFieldNumerPicker> {
  TextEditingController? _controller;
  int? inputValue;
//TODO: clean-up everything in here
  @override
  void initState() {
    inputValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(text: inputValue.toString());
    return BaseTFNumPicker(
      width: inputValue.toString().length.toDouble() * 42,
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
          inputValue = value.isEmpty ? 0 : int.tryParse(value);
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

    /* Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Text(widget.title),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (inputValue! > 0) {
                    setState(() {
                      inputValue = inputValue! - widget.changesByValue;
                      widget.onChange(inputValue!);
                    });
                  }
                },
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: inputValue! > 0 ? Colors.white : Colors.white30,
                        size: 40,
                      ),
                    ),
                    Text(
                      "${inputValue! - widget.changesByValue}",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
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
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    inputValue = inputValue! + widget.changesByValue;
                    widget.onChange(inputValue!);
                  });
                },
                child: Row(
                  children: [
                    Text(
                      "${inputValue! + widget.changesByValue}",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ); */
  }
}