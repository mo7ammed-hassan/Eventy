import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/payment/screens/successful_payment_screen.dart';
import 'package:eventy/features/payment/widgets/custom_payment_appbar.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';

class FawryPaymentScreen extends StatelessWidget {
  final String fawryCode;
  final String expireDate;
  final EventEntity event;

  const FawryPaymentScreen({
    super.key,
    required this.fawryCode,
    required this.expireDate,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPaymentAppBar(title: 'Fawry Payment'),
      body: Padding(
        padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
        child: Column(
          children: [
            Text(
              'Use this code to complete your payment:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              fawryCode,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Expires: $expireDate',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            Text(
              'You can pay at any Fawry outlet,\nFawry mobile app, or online banking',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: AppColors.eventyPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PaymentSuccessScreen(
                        event: event,
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  'I HAVE PAID',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
