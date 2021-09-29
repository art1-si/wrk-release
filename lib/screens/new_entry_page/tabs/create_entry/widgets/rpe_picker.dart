import 'package:flutter/material.dart';
import 'package:workout_notes_app/constants/lists.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

typedef void VoidIntCallback(int i);

class RPEPicker extends StatelessWidget {
  const RPEPicker({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final ValueChanged<int> onChanged;
  final int value;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: SizedBox(
        height: 90,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("RPE"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ConstLists.rpePicker
                  .map(
                    (rpe) => _Item(
                      onPressed: onChanged,
                      selectedColor: AppTheme.of(context).accentNegative,
                      rpe: rpe,
                      selected: rpe == value,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.rpe,
    required this.selected,
    required this.selectedColor,
    required this.onPressed,
  }) : super(key: key);
  final int rpe;
  final bool selected;
  final Color selectedColor;
  final VoidIntCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final _width = (MediaQuery.of(context).size.width - 16) / 10;
    return GestureDetector(
      onTap: () => onPressed(rpe),
      child: AnimatedContainer(
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: selected
              ? Border.all(color: selectedColor.withOpacity(0.2))
              : null,
          color: selected ? selectedColor.withOpacity(0.1) : null,
        ),
        duration: Duration(milliseconds: 250),
        child: SizedBox(
          height: 40,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 250),
              style: TextStyle(
                  fontSize: selected ? 24 : 14,
                  color: selected
                      ? selectedColor.withOpacity(0.7)
                      : Colors.white54,
                  fontWeight: selected ? FontWeight.bold : null),
              child: Text(
                rpe.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
