import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:workout_notes_app/services/logics.dart';

class LineDividers extends StatelessWidget {
  final int entryLength;
  final double minWeightValue;
  final double maxWeightValue;
  final Color dividerColor;

  const LineDividers({
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
