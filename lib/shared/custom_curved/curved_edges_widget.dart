import 'package:eventy/shared/custom_curved/custom_curved_edges.dart';
import 'package:flutter/material.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({super.key, this.child, this.curveHight = 50});
  final Widget? child;
  final double curveHight;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(curveHight: curveHight),
      child: child,
    );
  }
}
