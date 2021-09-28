import 'package:flutter/material.dart';
import 'package:workout_notes_app/constants/lists.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

typedef void VoidIntCallback(int i);

class RPEPicker extends StatefulWidget {
  const RPEPicker({Key? key}) : super(key: key);

  @override
  State<RPEPicker> createState() => _RPEPickerState();
}

class _RPEPickerState extends State<RPEPicker> {
  int _selectedRPE = 10;
  void handleOnPressed(int rpe) {
    setState(() {
      _selectedRPE = rpe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
                    onPressed: handleOnPressed,
                    selectedColor: AppTheme.of(context).accentPrimary,
                    rpe: rpe,
                    selected: rpe == _selectedRPE,
                  ),
                )
                .toList(),
          ),
        ],
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
          height: 50,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 250),
              style: TextStyle(
                  fontSize: selected ? 24 : 14,
                  color: selected
                      ? selectedColor.withOpacity(0.7)
                      : Colors.white70,
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
