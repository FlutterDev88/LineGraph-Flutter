import 'package:flutter/material.dart';

class MetaGraph {

  static double height = 200;
  static double width = 500;    //-- widthLabel + gapH * (markCntH - 1)

  static double graphT = 12.5;  //-- Graph Top    : heightLabel * 0.5
  static double graphB = 162.5; //-- Graph Bottom : height - heightLabel * 1.5
  static double axisB  = 175;   //-- Axis  Bottom : height - heightLabel

  static int    markCntV = 4;   //-- Mark Count Vertical
  static int    markCntH = 12;  //-- Mark Count Horizontal

  static double unitV = 12.5;    //-- Unit Vertical   : (graphBot - graphTop) / (markMaxV - markMinV)
  static double unitH = 80;      //-- Unit Horizontal : Spacing between vertical lines

  static double stroke = 2;
  static double radiusPoint = 4;

  static double heightLabel = 25; //-- Height of One Label
  static double widthLabel = 120;  //-- Width  of One Label

  static double markMinV = 12;  //-- Mark Min Vertical
  static double markMaxV = 24;  //-- Mark Max Vertical


  static void calculate(double heightWidget) {
    //-- Left  Margin is widthLabel / 2
    //-- Right Margin is widthLabel / 2
    width = widthLabel + unitH * (markCntH - 1);
    height = heightWidget;

    graphT = heightLabel * 0.5;
    graphB = height - heightLabel * 1.5;
    axisB  = height - heightLabel;

    unitV = graphB - graphT;
    unitV /= markMaxV - markMinV;
  }

  static Offset offsetFromScore(Offset score) {
    double x = score.dx * MetaGraph.unitH;
    x += MetaGraph.widthLabel / 2;  //-- Consider Left Margin
    double y = MetaGraph.graphB;
    y -= (score.dy - MetaGraph.markMinV) * MetaGraph.unitV;
    return Offset(x, y);
  }

}