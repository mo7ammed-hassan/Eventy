import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/payment/widgets/custom_payment_appbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:eventy/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class MeezaWalletScreen extends StatelessWidget {
  final String reference;
  final String qrCode;
  final String invoiceId;
  final String invoiceKey;

  const MeezaWalletScreen({
    super.key,
    required this.reference,
    required this.qrCode,
    required this.invoiceId,
    required this.invoiceKey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomPaymentAppBar(title: 'Meeza Wallet'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Scan QR Code to Pay',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImageView(
                data: qrCode.trim(),
                version: QrVersions.auto,
                size: 200,
                eyeStyle: QrEyeStyle(
                  color: isDark ? Colors.white : Colors.black,
                  eyeShape: QrEyeShape.square,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Or use Reference Number:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              reference,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            RowInfo(label: 'Invoice ID', value: invoiceId),
            const SizedBox(height: 10),
            RowInfo(label: 'Invoice Key', value: invoiceKey),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.eventyPrimaryColor,
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
          ],
        ),
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  const RowInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
