import 'package:flutter/material.dart';
import 'package:eventy/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class FawryPaymentScreen extends StatelessWidget {
  final String fawryCode;
  final String expireDate;

  const FawryPaymentScreen({
    super.key,
    required this.fawryCode,
    required this.expireDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fawry Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
        child: Column(
          children: [
            const Text(
              'Use this code to complete your payment:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              fawryCode,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('Expires: $expireDate', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            const Text(
              'You can pay at any Fawry outlet,\nFawry mobile app, or online banking',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'I HAVE PAID',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
