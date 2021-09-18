import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

typedef void VoidLogCallback(ExerciseLog);

class CurrentEntries extends StatelessWidget {
  const CurrentEntries({
    Key? key,
    required this.currentEntries,
    required this.onLongPressed,
  }) : super(key: key);

  final List<ExerciseLog> currentEntries;
  final VoidLogCallback onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 8.0,
          ),
          child: _EntryRow(),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: currentEntries.length,
          itemBuilder: (BuildContext context, index) {
            return _EntryRow(
              onLongPressed: () => onLongPressed(currentEntries[index]),
              entry: currentEntries[index],
            );
          },
          separatorBuilder: (_, __) => Divider(
            indent: 100,
            endIndent: 100,
            thickness: 2,
            color: AppTheme.of(context).divider,
          ),
        ),
      ],
    );
  }
}

class _EntryRow extends StatefulWidget {
  const _EntryRow({
    Key? key,
    this.entry,
    this.onLongPressed,
  }) : super(key: key);

  final ExerciseLog? entry;
  final VoidCallback? onLongPressed;

  @override
  State<_EntryRow> createState() => _EntryRowState();
}

class _EntryRowState extends State<_EntryRow> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongPressed!();
        setState(() {
          _selected = _selected ? false : true;
        });
      },
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: _selected ? AppTheme.of(context).primary : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Field(
              text: widget.entry?.setCount.toString() ?? "SET",
            ),
            _Field(
              text: widget.entry?.weight.toString() ?? "WEIGHT",
            ),
            _Field(
              text: widget.entry?.reps.toString() ?? "REPS",
            ),
            _Field(
              text: widget.entry?.exerciseRPE.toString() ?? "RPE",
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
