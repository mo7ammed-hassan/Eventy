import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';

class PrivacypolicyCheckBox extends StatefulWidget {
  const PrivacypolicyCheckBox({super.key, required this.onTermsAccepted});

  final ValueChanged<bool> onTermsAccepted;

  @override
  State<PrivacypolicyCheckBox> createState() => _PrivacypolicyCheckBoxState();
}

class _PrivacypolicyCheckBoxState extends State<PrivacypolicyCheckBox> {
  bool isTermsAccepted = false; // Moved to state level

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.primaryColor,
          value: isTermsAccepted,
          onChanged: (value) {
            setState(() {
              isTermsAccepted = value ?? false;
            });
            widget.onTermsAccepted(isTermsAccepted);
          },
        ),
        const Text(
          'I agree to the privacy policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
