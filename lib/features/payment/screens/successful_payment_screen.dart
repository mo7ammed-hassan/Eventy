import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart'
    show EventEntity;
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key, required this.event});
  final EventEntity event;

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    getIt<JoinedEventsCubit>().joinEvent(event: widget.event);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Spacer(),
              Flexible(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: isDark
                        ? AppColors.dateFieldColor.withValues(alpha: 0.1)
                        : AppColors.eventyPrimaryColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 60,
                    color: AppColors.eventyPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Success Title
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.eventyPrimaryColor,
                ),
              ),
              const SizedBox(height: 16),

              // Success Message
              Text(
                'Your payment has been processed successfully. '
                'You will receive a confirmation email shortly.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 0.1)),

              // Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? AppColors.eventyPrimaryColor
                        : AppColors.eventyPrimaryColor,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                    'Back to Home',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
