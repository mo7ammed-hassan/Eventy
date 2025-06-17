import 'package:flutter/material.dart';

class UploadEventImageSection extends StatelessWidget {
  const UploadEventImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      height: screenSize.height * 0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_a_photo,
              size: screenSize.width * 0.08, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
