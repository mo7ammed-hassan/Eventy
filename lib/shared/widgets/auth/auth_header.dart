import 'package:eventy/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:eventy/shared/custom_curved/curved_edges_widget.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(AppImages.opacityAuthImage, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
