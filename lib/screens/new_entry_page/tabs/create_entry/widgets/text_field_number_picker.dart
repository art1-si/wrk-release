import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/base_tf_num_picker.dart';

final textController = Provider.autoDispose<TextEditingController>((ref) {
  final _weight = ref.watch(createNewEntryProvider); //TODO: use select
  final controller = TextEditingController(text: _weight.reps.toString());

  /*  ref.onDispose(() {
    controller.dispose();
  }); */
//TODO: dispose
  return controller;
});

class TextFieldNumerPicker extends ConsumerWidget {
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
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return BaseTFNumPicker(
      width: initValue.toString().length.toDouble() * 36,
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
        controller: watch(textController),
        onChanged: (value) {
          var inputValue = value.isEmpty ? 0 : int.tryParse(value);
          context.read(createNewEntryProvider).repsSetter(inputValue!);
        },
      ),
      onPressedLeftArow: () {
        if (initValue > 0) {
          //TODO: 0.5 is greater then 0 so its true by can give negative value
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
