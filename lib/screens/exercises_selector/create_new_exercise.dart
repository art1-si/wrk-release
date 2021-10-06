import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/database/database.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class CreateNewExercise extends StatefulWidget {
  const CreateNewExercise({Key? key}) : super(key: key);

  @override
  State<CreateNewExercise> createState() => _CreateNewExerciseState();
}

class _CreateNewExerciseState extends State<CreateNewExercise> {
  bool _buttonDisable = true;
  String _name = "";
  String _type = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TextField(
              title: "Exercise name",
              value: (value) {
                _name = value;
                if (_type.isEmpty || _name.isEmpty) {
                  setState(() {
                    _buttonDisable = true;
                  });
                } else {
                  setState(() {
                    _buttonDisable = false;
                  });
                }
              },
              labelText: "Enter exercise name",
              hintText: "e.g. Leg Press",
            ),
            _TextField(
              title: "Exercise type",
              value: (value) {
                _type = value;
                if (_type.isEmpty || _name.isEmpty) {
                  setState(() {
                    _buttonDisable = true;
                  });
                } else {
                  setState(() {
                    _buttonDisable = false;
                  });
                }
              },
              labelText: "Enter exercise type",
              hintText: "e.g. Legs",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedHomePageButton(
                disable: _buttonDisable,
                width: MediaQuery.of(context).size.width,
                title: "Create",
                onPress: () {
                  if (_name.isNotEmpty && _type.isNotEmpty) {
                    context.read(databaseProvider).createExercise(Exercise(
                        id: documentIdFromCurrentDate(),
                        exerciseName: _name,
                        exerciseType: _type));

                    Navigator.pop(context);
                  }
                },
                backgroundColor:
                    AppTheme.of(context).accentPrimary.withOpacity(0.1),
                titleColor: AppTheme.of(context).accentPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField({
    Key? key,
    required this.title,
    required this.value,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);
  final String title;
  final ValueChanged<String> value;
  final String labelText;
  final String hintText;
  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  final _controller = TextEditingController();
  final TextStyle _labelTextStyle = TextStyle(color: Colors.white38);
  final TextStyle _headerTextStyle =
      TextStyle(color: Colors.white, fontSize: 24.0);
  String? get errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can not be empty';
    }

    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                style: _headerTextStyle,
              ),
              TextFormField(
                decoration: InputDecoration(
                  errorText: errorText,
                  labelStyle: _labelTextStyle,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  hintStyle: _labelTextStyle,
                ),
                controller: _controller,
                onChanged: widget.value,
              ),
            ],
          );
        });
  }
}
