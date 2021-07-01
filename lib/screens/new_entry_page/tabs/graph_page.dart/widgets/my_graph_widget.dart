import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:workout_notes_app/data_models/exercise_log.dart';

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
