import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/details/presentation/widgets/details_header_section.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventOrganizerSection extends StatefulWidget {
  const EventOrganizerSection({
    super.key,
    required this.imageUrl,
    required this.hostCompany,
    required this.category,
  });

  final String? imageUrl;
  final String hostCompany;
  final String category;

  @override
  State<EventOrganizerSection> createState() => _EventOrganizerSectionState();
}

class _EventOrganizerSectionState extends State<EventOrganizerSection> {
  late final userCubit = getIt<UserCubit>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userCubit.getUserProfileById(id: widget.hostCompany);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsHeaderSection(title: 'Organizer'),
        const SizedBox(height: AppSizes.spaceBtwTextField),
        BlocBuilder<UserCubit, UserState>(
          buildWhen: (prev, curr) => prev.userById?.id != curr.userById?.id,
          builder: (context, state) {
            final user = state.userById ?? UserEntity.empty();

            return Row(
              children: [
                CachedNetworkImage(
                  imageUrl: user.imageUrl.isNotEmpty
                      ? user.imageUrl
                      : widget.imageUrl ?? '',
                  imageBuilder: (_, imageProvider) =>
                      CircleAvatar(radius: 20, backgroundImage: imageProvider),
                  placeholder: (_, __) => const ShimmerWidget(
                    width: 40,
                    height: 40,
                    shapeBorder: CircleBorder(),
                  ),
                  errorWidget: (_, __, ___) => const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.error, size: 18),
                  ),
                ),
                const SizedBox(width: AppSizes.slg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        user.email.isNotEmpty
                            ? user.email
                            : 'No email available',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
