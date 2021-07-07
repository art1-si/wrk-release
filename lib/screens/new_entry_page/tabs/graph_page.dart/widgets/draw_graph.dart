import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class DrawGraph extends CustomPainter {
  const DrawGraph({
    Key? key,
    required this.entries,
    required this.lineColor,
    required this.tappedEntryIndex,
  });

  final List<GraphModel> entries;
  final int? tappedEntryIndex;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    Color gradinetColorStarter = (tappedEntryIndex == null)
        ? lineColor.withOpacity(0.1)
        : Colors.orange[300]!.withOpacity(0.1);
    Color endGradinetColor = (tappedEntryIndex == null)
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
      ..color = (tappedEntryIndex == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Paint points = Paint()
      ..color = (tappedEntryIndex == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    entries.forEach((element) {
      double _dx = element.x * size.width;
      double _dy = element.y * size.height;
      double _nextDx = element.nextX * size.width;
      double _nextDy = element.nextY * size.height;
      //Draw main line
      canvas.drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);

      //Draw background
      canvas.drawPath(
        Path()
          ..moveTo(_dx, _dy)
          ..lineTo(_dx, size.height)
          ..lineTo(_nextDx, size.height)
          ..lineTo(_nextDx, _nextDy),
        shadowLine2,
      );
    });
    if (tappedEntryIndex != null) {
      canvas.drawLine(
          Offset(entries[tappedEntryIndex!].x * size.width,
              entries[tappedEntryIndex!].y * size.height),
          Offset(entries[tappedEntryIndex!].x * size.width,
              entries[tappedEntryIndex!].y * size.height),
          points);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
