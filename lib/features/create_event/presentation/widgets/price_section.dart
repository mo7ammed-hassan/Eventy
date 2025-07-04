import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSection extends StatefulWidget {
  final TextEditingController? priceController;
  final bool isDark;

  const PriceSection({
    super.key,
    required this.priceController,
    required this.isDark,
  });

  @override
  State<PriceSection> createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.watch<CreateEventCubit>();
    final isPaid = cubit.isPaid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: 14),
        ),

        Row(
          children: [
            Radio<bool>(
              value: false,
              groupValue: isPaid,
              onChanged: (value) {
                cubit.setPaid(value!);
                widget.priceController?.clear();
              },
            ),
            const Text('Free'),
            const SizedBox(width: 16),
            Radio<bool>(
              value: true,
              groupValue: isPaid,
              onChanged: (value) {
                cubit.setPaid(value!);
              },
            ),
            const Text('Paid'),
          ],
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          child: isPaid
              ? Column(
                  children: [
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: widget.priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      decoration: HelperFunctions.buildFieldDecoration(
                        widget.isDark,
                        hint: 'Price',
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
