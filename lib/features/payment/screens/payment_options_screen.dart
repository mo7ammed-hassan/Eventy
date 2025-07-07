import 'package:dio/dio.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/payment/widgets/custom_payment_appbar.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/payment/models/fawry_response_model.dart';
import 'package:eventy/features/payment/models/meeza_wallet_model.dart';
import 'package:eventy/features/payment/models/payment_method_model.dart';
import 'package:eventy/features/payment/models/visa_response_model.dart';
import 'package:eventy/features/payment/screens/fawry_payment_screen.dart';
import 'package:eventy/features/payment/screens/meeza_wallet_screen.dart';
import 'package:eventy/features/payment/screens/web_view.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd',
      },
    ),
  )..interceptors.add(PrettyDioLogger());

  late Future<PaymentMethod?> _paymentMethodsFuture;
  bool _isProcessing = false;
  int? _selectedPaymentId;

  @override
  void initState() {
    super.initState();
    _paymentMethodsFuture = _fetchPaymentMethods();
  }

  Future<PaymentMethod?> _fetchPaymentMethods() async {
    try {
      final response = await _dio.get(
        'https://staging.fawaterk.com/api/v2/getPaymentmethods',
      );
      return PaymentMethod.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching payment methods: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    if (_selectedPaymentId == null) return;

    setState(() => _isProcessing = true);

    try {
      final response = await _dio.post(
        'https://staging.fawaterk.com/api/v2/invoiceInitPay',
        data: _buildPaymentRequest(_selectedPaymentId!),
      );
      _handlePaymentResponse(_selectedPaymentId!, response.data);
    } catch (e) {
      _showErrorSnackbar('Payment failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Map<String, dynamic> _buildPaymentRequest(int methodId) => {
    'payment_method_id': methodId,
    'cartTotal': '100',
    'currency': 'EGP',
    'customer': {
      'first_name': 'test',
      'last_name': 'test',
      'email': 'test@test.test',
      'phone': '01008650689',
      'address': 'test address',
    },
    'redirectionUrls': {
      'successUrl':
          'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/success',
      'failUrl':
          'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/fail',
      'pendingUrl':
          'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/pending',
    },
    'cartItems': [
      {'name': 'test', 'price': '100', 'quantity': '1'},
    ],
  };

  void _handlePaymentResponse(int methodId, dynamic data) {
    switch (methodId) {
      case 2: // Visa
        final visaResponse = VisaResponseModel.fromJson(data);
        if (visaResponse.data?.paymentData?.redirectTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  WebView(url: visaResponse.data!.paymentData!.redirectTo!),
            ),
          );
        } else {
          throw Exception('Redirect URL not found');
        }
        break;

      case 3: // Fawry
        final fawryResponse = FawryResponseModel.fromJson(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FawryPaymentScreen(
              fawryCode: fawryResponse.data.paymentData.fawryCode,
              expireDate: fawryResponse.data.paymentData.expireDate,
            ),
          ),
        );
        break;

      case 4: // Meeza Wallet
        final meezaResponse = MeezaWalletModel.fromJson(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MeezaWalletScreen(
              reference: meezaResponse.data.paymentData.meezaReference
                  .toString(),
              qrCode: meezaResponse.data.paymentData.meezaQrCode,
              invoiceId: meezaResponse.data.invoiceId.toString(),
              invoiceKey: meezaResponse.data.invoiceKey,
            ),
          ),
        );
        break;

      default:
        throw Exception('Unsupported payment method');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomPaymentAppBar(title: 'Select Payment Method'),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceBtwItems,
            vertical: AppSizes.defaultPadding / 2,
          ),
          child: Column(
            children: [
              Expanded(
                child: _isProcessing
                    ? const Center(child: CircularProgressIndicator())
                    : FutureBuilder<PaymentMethod?>(
                        future: _paymentMethodsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('Failed to load payment methods'),
                            );
                          }

                          final filteredMethods = snapshot.data!.data!
                              .where((m) => [2, 3, 4].contains(m.paymentId))
                              .toList();

                          return ListView.builder(
                            padding: EdgeInsets.only(
                              top: AppSizes.defaultPadding,
                            ),
                            itemCount: filteredMethods.length,
                            itemBuilder: (_, index) {
                              final method = filteredMethods[index];
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: _selectedPaymentId == method.paymentId
                                      ? AppColors.eventyPrimaryColor
                                      : isDark
                                      ? AppColors.dark
                                      : AppColors.dateFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: RadioListTile<int>(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),

                                  activeColor:
                                      _selectedPaymentId == method.paymentId
                                      ? Colors.white
                                      : isDark
                                      ? Colors.white
                                      : AppColors.primaryColor,
                                  contentPadding: const EdgeInsets.all(12),
                                  title: Text(
                                    method.nameEn!,
                                    style: TextStyle(
                                      color:
                                          _selectedPaymentId == method.paymentId
                                          ? Colors.white
                                          : isDark
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    method.nameAr!,
                                    style: TextStyle(
                                      color:
                                          _selectedPaymentId == method.paymentId
                                          ? Colors.white
                                          : isDark
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                    ),
                                  ),
                                  secondary: Image.network(
                                    method.logo!,
                                    height: 80,
                                    errorBuilder: (_, _, _) =>
                                        const Icon(Icons.payment),
                                  ),
                                  value: method.paymentId!,
                                  groupValue: _selectedPaymentId,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedPaymentId = value;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              AnimatedContinueButton(
                isEnabled: _selectedPaymentId != null && !_isProcessing,
                onPressed: _processPayment,
              ),
              SizedBox(height: kBottomNavigationBarHeight / 2),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedContinueButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const AnimatedContinueButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.eventyPrimaryColor
              : AppColors.eventyPrimaryColor.withValues(alpha: 0.5),
          foregroundColor: isEnabled ? Colors.white : Colors.grey.shade300,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: isDark
              ? AppColors.dark
              : AppColors.primaryColor.withValues(alpha: 0.5),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isEnabled ? 4 : 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            'Continue',
            key: ValueKey<bool>(isEnabled),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
