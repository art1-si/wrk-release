import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

typedef void VoidLogCallback(ExerciseLog? log);

class CurrentEntries extends StatefulWidget {
  const CurrentEntries({
    Key? key,
    required this.currentEntries,
    required this.onLongPressed,
  }) : super(key: key);

  final List<ExerciseLog> currentEntries;
  final VoidLogCallback onLongPressed;

  @override
  State<CurrentEntries> createState() => _CurrentEntriesState();
}

class _CurrentEntriesState extends State<CurrentEntries> {
  ExerciseLog? _selectedLog;
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
          itemCount: widget.currentEntries.length,
          itemBuilder: (BuildContext context, index) {
            return _EntryRow(
              setCount: index + 1,
              onLongPressed: () {
                setState(() {
                  if (_selectedLog != widget.currentEntries[index]) {
                    _selectedLog = widget.currentEntries[index];
                    widget.onLongPressed(_selectedLog);
                  } else {
                    _selectedLog = null;
                    widget.onLongPressed(_selectedLog);
                  }
                });
              },
              entry: widget.currentEntries[index],
              selected: widget.currentEntries[index] == _selectedLog,
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

class _EntryRow extends StatelessWidget {
  const _EntryRow({
    Key? key,
    this.entry,
    this.onLongPressed,
    this.selected = false,
    this.setCount,
  }) : super(key: key);

  final ExerciseLog? entry;
  final VoidCallback? onLongPressed;
  final int? setCount;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLongPressed,
      child: SizedBox(
        height: 30,
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                height: selected ? 30 : 10,
                width: selected ? MediaQuery.of(context).size.width : 10,
                decoration: BoxDecoration(
                  color: selected
                      ? AppTheme.of(context).accentPositive.withOpacity(0.05)
                      : null,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              style: TextStyle(
                color: selected ? Colors.white : Colors.white54,
                fontSize: selected ? 18 : 14,
                fontWeight: selected ? FontWeight.bold : FontWeight.w400,
              ),
              duration: Duration(milliseconds: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Field(
                    text: setCount?.toString() ?? "SET",
                  ),
                  _Field(
                    text: entry?.weight.toString() ?? "WEIGHT",
                  ),
                  _Field(
                    text: entry?.reps.toString() ?? "REPS",
                  ),
                  _Field(
                    text: entry?.exerciseRPE.toString() ?? "RPE",
                  ),
                ],
              ),
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
