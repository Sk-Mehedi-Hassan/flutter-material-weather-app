// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class App1 extends StatelessWidget {
//   const App1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<int> list = generateRandomList();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
//       ),
//       home: SafeArea(
//         child: Scaffold(
//           body: ListView(
//             scrollDirection: Axis.horizontal,
//             children: list.map((e) => Text(e.toString())).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// List<int> generateRandomList() {
//   final rn = Random();
//   List<int> result = [];
//   for (int i = 0; i < 100; i++) {
//     result.add(rn.nextInt(100));
//   }
//
//   return result;
// }
// import 'package:flutter/material.dart';
//
// class Data {
//   final double x;
//   final double y;
//   Data(this.x, this.y);
// }
//
// List<Data> datalist = [Data(0, 0)];
//
// class LineCharWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: CustomPaint(
//         child: Container(),
//         painter: LineChartPainter(datalist),
//       ),
//     );
//   }
// }
//
// class LineChartPainter extends CustomPainter {
//   final List<Data> data;
//   late double _min, _max;
//   late List<double> _Y;
//   late List<double> _X;
//
//   LineChartPainter(this.data) {
//     var min = double.maxFinite;
//     var max = -double.maxFinite;
//     data.forEach((element) {
//       min = min > element.x ? element.x : min;
//       max = max > element.x ? element.x : max;
//     });
//     _min = min;
//     _max = max;
//
//     _Y = data.map((e) => e.y).toList();
//     _Y = data.map((e) => e.x).toList();
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final drawableHeight = size.height - 2 * border;
//     final drawableWidth = size.width - 2 * border;
//
//     final hu = drawableHeight / 5.0;
//     final wu = drawableWidth / _X.length.toDouble();
//
//     final boxH = hu * 3.0;
//     final boxW = wu;
//
//     if (boxW <= 0.0 || boxH <= 0.0) return;
//     if (_max - _min < 1.0e-6) return;
//
//     final hr = boxH / (_max - _min);
//     final lt = Offset(border + boxW / 2.0, border);
//     final points = _computePoints(lt, boxW, boxH, hr);
//     final path = _computePath(points);
//     canvas.drawPath(path, linePaint);
//     _drawDataPoints(canvas, points, dotPaintFill);
//
//     final labels = _computeLabels();
//     _drawYLabels(canvas, labels, points, boxW, border);
//
//     // draw x labels
//     final lt1 = Offset(border + boxW / 2.0, border + 4.5 * hu);
//     _drawXLabels(canvas, lt1, boxW);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
//
//   List<Offset> _computePoints(Offset lt, double boxW, double boxH, double hr) {
//     return _Y.map((yp) {
//       final yy = boxH - (yp - _min) * hr;
//       final dp = lt + Offset(0, yy);
//       lt += Offset(boxW, 0);
//       return dp;
//     }).toList();
//   }
//
//   Path _computePath(List<Offset> points) {
//     final path = Path();
//     for (var i = 0; i < points.length; i++) {
//       final p = points[i];
//       if (i == 0) {
//         path.moveTo(p.dx, p.dy);
//       } else {
//         path.lineTo(p.dx, p.dy);
//       }
//     }
//     return path;
//   }
//
//   void _drawDataPoints(Canvas canvas, List<Offset> points, Paint dotPaintFill) {
//     points.forEach((dp) {
//       canvas.drawCircle(dp, radius, dotPaintFill);
//       canvas.drawCircle(dp, radius, linePaint);
//     });
//   }
//
//   List<String> _computeLabels() {
//     return _Y.map((yp) => "${yp.toStringAsFixed(1)}").toList();
//   }
//
//   void _drawYLabels(Canvas canvas, List<String> labels, List<Offset> points,
//       double boxW, double top) {
//     var i = 0;
//     labels.forEach((label) {
//       final dp = points[i];
//       final dy = (dp.dy - 15.0) < top ? 15.0 : -15.0;
//       final ly = dp + Offset(0, dy);
//       drawTextCentered(canvas, ly, label, yLabelStyle, boxW);
//       i++;
//     });
//   }
//
//   void _drawXLabels(Canvas canvas, Offset c, double boxW) {
//     _X.forEach((xp) {
//       drawTextCentered(canvas, c, xp, xLabelStyle, boxW);
//       c += Offset(boxW, 0);
//     });
//   }
//
//   TextPainter measureText(
//       String s, TextStyle style, double maxWidth, TextAlign align) {
//     final span = TextSpan(text: s, style: style);
//     final tp = TextPainter(
//         text: span, textAlign: align, textDirection: TextDirection.ltr);
//     tp.layout(minWidth: 0, maxWidth: maxWidth);
//     return tp;
//   }
//
//   Size drawTextCentered(
//       Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
//     final tp = measureText(text, style, maxWidth, TextAlign.center);
//     final offset = c + Offset(-tp.width / 2.0, -tp.height / 2.0);
//     tp.paint(canvas, offset);
//     return tp.size;
//   }
// }
