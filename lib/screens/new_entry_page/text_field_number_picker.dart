import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/provider/log_values_provider.dart';

class WeightNumberPicker extends StatelessWidget {
  final String title;
  final dynamic numberValue;
  final dynamic numberChangeValue;
  final ValueChanged<dynamic>? onValueChange;
  final bool? isDouble;
  final GestureTapCallback? onTapLeftButton;
  final GestureTapCallback? onTapRightButton;
  WeightNumberPicker({
    required this.title,
    this.isDouble,
    this.numberValue,
    this.numberChangeValue,
    this.onValueChange,
    this.onTapLeftButton,
    this.onTapRightButton,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController;
    var logValuesProvider =
        Provider.of<LogValuesProvider>(context, listen: false);
    return Consumer<LogValuesProvider>(
      builder: (context, log, child) {
        _textEditingController =
            TextEditingController(text: "${log.weightValue}");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Divider(
                thickness: 1,
                height: 0,
              ),
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onTapLeftButton,
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: (logValuesProvider.weightValue > 0)
                            ? Colors.white
                            : Colors.white30,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          log.setWeightTo(double.parse(value));
                        },
                        controller: _textEditingController,
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 0.5,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        //showCursor: false,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapRightButton,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
