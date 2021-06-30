import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/services/logics.dart';

import 'dart:ui' as ui;

import 'package:workout_notes_app/provider/graph_detail_provider.dart';

class MyGraphWidget extends StatelessWidget {
  final List<ExerciseLog> exerciseLog;
  MyGraphWidget({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWeight = 0;
    double minWeight = 100000;
    if (exerciseLog.length > 1) {
      exerciseLog.forEach((element) {
        if (element.weight > maxWeight) {
          maxWeight = element.weight;
        }
        if (element.weight < minWeight) {
          minWeight = element.weight;
        }
      });
    } else if (exerciseLog.isNotEmpty) {
      maxWeight = exerciseLog.first.weight * 2;

      minWeight = 0;
    }

    if (exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    return Column(
      children: [
        _OnPressDialog(
          weight: 2,
          reps: 2,
          dateCreated: "",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Container(
            height: 250,
            //decoration: BoxDecoration(
            //   color: Theme.of(context).primaryColor,
            //    borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 4,
                right: 0.0,
                top: 8,
              ),
              child: Stack(
                children: [
                  LineDivders(
                    dividerColor: Theme.of(context).dividerColor,
                    minWeightValue: minWeight,
                    maxWeightValue: maxWeight,
                    entryLength: exerciseLog.length,
                  ),
                  MyDrawGraph(
                    snapshotToPass: exerciseLog,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyDrawGraph extends StatefulWidget {
  final List<ExerciseLog> snapshotToPass;

  const MyDrawGraph({Key? key, required this.snapshotToPass}) : super(key: key);
  @override
  _MyDrawGraphState createState() => _MyDrawGraphState();
}

class _MyDrawGraphState extends State<MyDrawGraph> {
  Offset? _tapPosition;
  bool isPressed = false;
  var referenceBox;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width - 50;
    List listOfXOffset = <double>[];
    var index = 0;
    if (_tapPosition != null) {
      if (widget.snapshotToPass.isNotEmpty &&
          widget.snapshotToPass.length > 1) {
        var len = 50.0;
        var len2 = (sizeWidth - 50) / (widget.snapshotToPass.length - 1);
        widget.snapshotToPass.forEach((element) {
          listOfXOffset.add(len);
          len = len + len2;
        });
        var distance = listOfXOffset[1] - listOfXOffset.first;
        for (var i = 0; i < listOfXOffset.length; i++) {
          if (listOfXOffset[i] < _tapPosition!.dx + distance / 2 &&
              listOfXOffset[i] + distance > _tapPosition!.dx + distance / 2) {
            index = i;
          }
        }
      }
    }
    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanEnd: (details) {
        setState(() {
          _tapPosition = null;
        });
      },
      onPanCancel: () {
        setState(() {
          _tapPosition = null;
        });
      },
      child: CustomPaint(
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        painter: DrawGraph(
          sizeWidth: MediaQuery.of(context).size.width - 50,
          lineColor: Theme.of(context).accentColor,
          entry: widget.snapshotToPass,
          linePosition: _tapPosition!,
        ),
      ),
    );
  }
}

class _OnPressDialog extends StatelessWidget {
  final double weight;
  final int reps;
  final String dateCreated;

  _OnPressDialog({
    Key? key,
    required this.weight,
    required this.reps,
    required this.dateCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PopUpTable(
      field1: "WEIGHT $weight",
      field2: "$reps",
      field4: "Date $dateCreated",
      field3: "rpe",
    );
  }
}

class _PopUpTable extends StatelessWidget {
  final String field1;
  final String field2;
  final String field3;
  final String field4;

  const _PopUpTable({
    Key? key,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$field1 x $field2",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                field4,
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineDivders extends StatelessWidget {
  final int entryLength;
  final double minWeightValue;
  final double maxWeightValue;
  final Color dividerColor;

  const LineDivders({
    Key? key,
    required this.minWeightValue,
    required this.maxWeightValue,
    required this.dividerColor,
    required this.entryLength,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          _DrawLines(minWeightValue, maxWeightValue, dividerColor, entryLength),
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
    );
  }
}

class _DrawLines extends CustomPainter {
  final int entryLength;
  final double? minWeightValue;
  final double maxWeightValue;
  final Color dividerColor;

  _DrawLines(this.minWeightValue, this.maxWeightValue, this.dividerColor,
      this.entryLength);
  @override
  void paint(Canvas canvas, Size size) {
    createdWeightParagraph(Canvas canvas, paragraphXoffset, text) {
      final textStyle = ui.TextStyle(
        color: Colors.white54,
        fontSize: 10,
        letterSpacing: 1.5,
      );
      final paragraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr,
      );
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText('$text');
      final constraints = ui.ParagraphConstraints(width: 50);
      final paragraph = paragraphBuilder.build();
      paragraph.layout(constraints);
      return canvas.drawParagraph(paragraph, Offset(0, paragraphXoffset));
    }

    Paint dividerLine = Paint()
      ..color = dividerColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5;
    if (minWeightValue != null && minWeightValue != maxWeightValue) {
      var weightValue = minWeightValue;
      for (var i = 0; i < 11; i++) {
        double weightGraphValue = roundDouble(weightValue!, 2);
        double relativeYposition = (weightGraphValue - minWeightValue!) /
            (maxWeightValue - minWeightValue!);
        double yOffset = size.height - relativeYposition * size.height;

        canvas.drawLine(
            Offset(0, yOffset), Offset(size.width, yOffset), dividerLine);

        createdWeightParagraph(canvas, yOffset - 12, weightGraphValue);

        weightValue += (maxWeightValue - minWeightValue!) / 10;
      }
    } else {
      createdWeightParagraph(canvas, size.height / 2, maxWeightValue);

      canvas.drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), dividerLine);
    }
    var gridGap = size.width / 5;
    var gap = gridGap;
    for (var i = 0; i < 5; i++) {
      canvas.drawLine(
          Offset(gap, -10), Offset(gap, size.height + 10), dividerLine);
      gap = gap + gridGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DrawGraph extends CustomPainter {
  final Offset? linePosition;
  final List<ExerciseLog> entry;
  final Color lineColor;

  final TextStyle? paragraphStyle;
  final double sizeWidth;

  const DrawGraph({
    Key? key,
    required this.linePosition,
    required this.sizeWidth,
    required this.entry,
    required this.lineColor,
    this.paragraphStyle,
  });

  createdWeightParagraph(Canvas canvas, paragraphXoffset, index, text) {
    final textStyle = ui.TextStyle(
      color: Colors.white54,
      fontSize: 10,
      letterSpacing: 1.5,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('$text');
    final constraints = ui.ParagraphConstraints(width: 50);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    return canvas.drawParagraph(paragraph, Offset(0, paragraphXoffset));
  }

  @override
  void paint(Canvas canvas, Size size) {
    int index = 0;
    double maxWeightValue = 0;
    double minWeightValue = 1000000;
    double len = 50;
    double len2 = (size.width - 50) / (entry.length - 1);
    double lastWeighValue = entry.first.weight;
    List listOfXOffset = <double>[];
    List listOfYOffset = <double>[];
    var entryWithoutRepeatValues = [];

    entry.forEach((element) {
      entryWithoutRepeatValues.add(element.weight);

      if (element.weight > maxWeightValue) {
        maxWeightValue = element.weight;
      }
      if (element.weight < minWeightValue) {
        minWeightValue = element.weight;
      }
    });

    var e = entryWithoutRepeatValues.toSet();
    Color gradinetColorStarter = (linePosition == null)
        ? lineColor.withOpacity(0.1)
        : Colors.orange[300]!.withOpacity(0.1);
    Color endGradinetColor = (linePosition == null)
        ? Colors.blue.withOpacity(0.005)
        : Colors.blue.withOpacity(0.005);
    final gradient = LinearGradient(
      colors: [gradinetColorStarter, endGradinetColor],
      stops: [0.4, 0.99],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    Paint shadowLine2 = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Paint line2 = Paint()
      ..color = (linePosition == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Paint points = Paint()
      ..color = (linePosition == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    index = 0;
    maxWeightValue = 0;
    minWeightValue = 1000;
    len = 50;
    len2 = (sizeWidth - 50) / (entry.length - 1);
    lastWeighValue = entry.first.weight;

    entry.forEach((element) {
      if (element.weight > maxWeightValue) {
        maxWeightValue = element.weight;
      }
      if (element.weight < minWeightValue) {
        minWeightValue = element.weight;
      }
    });

    if (entry.isNotEmpty && e.length > 1) {
      entry.forEach((element) {
        double weightGraphValue = element.weight;
        double relativeYposition = (weightGraphValue - minWeightValue) /
            (maxWeightValue - minWeightValue);
        double yOffset = size.height - relativeYposition * size.height;

        double lastRelativeYposition = (lastWeighValue - minWeightValue) /
            (maxWeightValue - minWeightValue);
        double yLastOffset = size.height - lastRelativeYposition * size.height;

        listOfXOffset.add(len);
        listOfYOffset.add(yOffset);
        canvas.drawLine(Offset(len, yOffset),
            Offset(((len == 50) ? len : len - len2), yLastOffset), line2);

        canvas.drawPath(
          Path()
            ..moveTo((len == 50) ? len : len - len2, size.height - 5)
            ..lineTo(len, size.height - 5)
            ..lineTo(len, yOffset)
            ..lineTo((len == 50) ? len : len - len2, yLastOffset),
          shadowLine2,
        );

        len = len + len2;
        lastWeighValue = element.weight;
        index++;
      });
    } else {
      listOfXOffset = [];
      len = 50;
      len2 = (sizeWidth - 50) / (entry.length - 1);
      entry.forEach((element) {
        listOfXOffset.add(len);
        canvas.drawLine(Offset(len, size.height / 2),
            Offset(((len == 50) ? len : len - len2), size.height / 2), line2);
        canvas.drawPath(
          Path()
            ..moveTo((len == 50) ? len : len - len2, size.height - 5)
            ..lineTo(len, size.height - 5)
            ..lineTo(len, size.height / 2)
            ..lineTo((len == 50) ? len : len - len2, size.height / 2),
          shadowLine2,
        );
        len = len + len2;
      });
    }

    if (linePosition != null && listOfXOffset.isNotEmpty) {
      var distance = listOfXOffset[1] - listOfXOffset.first;

      for (var i = 0; i < listOfXOffset.length; i++) {
        if (listOfXOffset[i] < linePosition!.dx + distance / 2 &&
            listOfXOffset[i] + distance > linePosition!.dx + distance / 2) {
          canvas.drawLine(
              Offset(listOfXOffset[i],
                  (listOfYOffset.isEmpty) ? size.height / 2 : listOfYOffset[i]),
              Offset(listOfXOffset[i],
                  (listOfYOffset.isEmpty) ? size.height / 2 : listOfYOffset[i]),
              points);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
