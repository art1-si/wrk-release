import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';

class DaySelector extends ConsumerWidget {
  const DaySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final date = watch(selectedDateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read(selectedDateProvider).decrement();
            },
            child: Container(
              height: 24,
              width: 50,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () => date.resetDate(),
            child: Text(
              date.daySelectedToText(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read(selectedDateProvider).increment();
            },
            child: Container(
              height: 24,
              width: 50,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
