import 'package:flutter/material.dart';

class TextFieldNumerPicker extends StatefulWidget {
  const TextFieldNumerPicker({
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
  _TextFieldNumerPickerState createState() => _TextFieldNumerPickerState();
}

class _TextFieldNumerPickerState extends State<TextFieldNumerPicker> {
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
    _controller = TextEditingController(text: inputValue.toString());
    return Padding(
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
    );
  }
}
