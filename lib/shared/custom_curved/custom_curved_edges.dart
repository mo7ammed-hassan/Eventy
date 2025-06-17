import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  final double curveHight;

  CustomCurvedEdges({ required this.curveHight});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    // first Curve
    final firstCurve = Offset(0, size.height - curveHight);
    final lastCurve = Offset(curveHight, size.height - curveHight);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx,
        lastCurve.dy); // (x1, y1, x2, y2)

    // second Curve
    final secondFirstCurve = Offset(0, size.height - curveHight);
    final secondLastCurve = Offset(size.width - curveHight, size.height - curveHight);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy); // (x1, y1, x2, y2)

    // lst
    final thiredFirstCurve = Offset(size.width, size.height - curveHight);
    final thiredlastCurve = Offset(size.width, size.height);

    path.quadraticBezierTo(thiredFirstCurve.dx, secondFirstCurve.dy,
        thiredlastCurve.dx, thiredlastCurve.dy); // (x1, y1, x2, y2)

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
