import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class DaySelector extends ConsumerWidget {
  const DaySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final date = watch(selectedDateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.of(context).primary,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 42,
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
              onDoubleTap: () => context.read(selectedDateProvider).resetDate(),
              child: AnimatedDateText(
                title: date.daySelectedToText(),
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
      ),
    );
  }
}

class AnimatedDateText extends StatelessWidget {
  const AnimatedDateText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
