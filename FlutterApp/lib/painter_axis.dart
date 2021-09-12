import 'package:flutter/material.dart';
import 'package:line_graph/meta_graph.dart';


class PainterAxis extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    //-- Draw Vertical Axis Values
    for (int i = 0; i < MetaGraph.markCntV; i++) {
      double val = MetaGraph.markMaxV;
      double gap = MetaGraph.markMaxV - MetaGraph.markMinV;
      gap /= MetaGraph.markCntV - 1;
      gap *= i;
      val -= gap;

      double y = MetaGraph.graphT;
      y += MetaGraph.unitV * gap;
      y -= MetaGraph.heightLabel / 2;

      String sVal = val.toInt().toString();

      TextSpan span = new TextSpan(
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24.0,
        ),
        text: sVal,
      );
      TextPainter tp = new TextPainter(
        text: span,
        textDirection: TextDirection.ltr
      );
      tp.layout();
      tp.paint(canvas, new Offset(10, y));
    }

    //-- Draw Line
    canvas.drawLine(
      Offset(size.width - 1, 0),
      Offset(size.width - 1, MetaGraph.axisB),
      paint
    );
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

