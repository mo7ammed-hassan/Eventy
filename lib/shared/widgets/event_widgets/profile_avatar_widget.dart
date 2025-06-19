import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

/// A customizable circular profile avatar widget that supports:
/// - Network images
/// - Local files
/// - Editable mode with image selection
/// - Various customization options
class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    super.key,
    this.radius = 22,
    this.showEditButton = false,
    this.showBorder = false,
    this.borderColor = AppColors.darkGrey,
    this.borderWidth = 2,
    this.editButtonSize = 18,
    this.editButtonColor = Colors.black,
    this.editButtonBgColor = AppColors.softGrey,
    this.defaultAvatarIcon = Iconsax.user,
    this.onImageSelected,
  });

  /// The radius of the avatar circle
  final double radius;

  /// Whether to show the edit button
  final bool showEditButton;

  /// Whether to show a border around the avatar
  final bool showBorder;

  /// Color of the border (if showBorder is true)
  final Color borderColor;

  /// Width of the border (if showBorder is true)
  final double borderWidth;

  /// Size of the edit button icon
  final double editButtonSize;

  /// Color of the edit button icon
  final Color editButtonColor;

  /// Background color of the edit button
  final Color editButtonBgColor;

  /// Default icon to show when no image is available
  final IconData defaultAvatarIcon;

  /// Callback when a new image is selected (receives the file path)
  final Function(String)? onImageSelected;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool _isOpenToUpload = false;

  Future<void> _handleImageSelection() async {
    FocusScope.of(context).unfocus();
    if (_isOpenToUpload) return;
    setState(() => _isOpenToUpload = true);

    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Medium quality for better performance
      );

      if (pickedFile != null && mounted) {
        final imagePath = pickedFile.path.replaceAll(' ', '-');
        context.read<UserCubit>().updateProfileImage(imagePath);
        widget.onImageSelected?.call(imagePath);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Image Selection Error',
        message: 'Failed to select image: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() => _isOpenToUpload = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shimmerSize = widget.radius * 2;
    final errorIconSize = widget.radius * 0.8;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: widget.showBorder
            ? Border.all(color: widget.borderColor, width: widget.borderWidth)
            : null,
      ),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar Image
            BlocSelector<
              UserCubit,
              UserState,
              (String imageUrl, bool isUpdatingImage, bool isLoading)
            >(
              selector: (state) => (
                state.user?.imageUrl ?? '',
                state.isUpdatingImage,
                state.isLoading,
              ),
              builder: (context, imageUpdate) {
                final (imageUrl, isUpdating, isLoading) = imageUpdate;

                if (isUpdating || imageUrl.isEmpty || isLoading) {
                  return ClipOval(
                    child: ShimmerWidget(
                      width: shimmerSize,
                      height: shimmerSize,
                    ),
                  );
                }

                if (!imageUrl.startsWith('http')) {
                  final file = File(imageUrl);
                  if (!file.existsSync()) {
                    return CircleAvatar(
                      radius: widget.radius,
                      child: Icon(
                        widget.defaultAvatarIcon,
                        size: errorIconSize,
                      ),
                    );
                  }
                  return CircleAvatar(
                    radius: widget.radius,
                    backgroundImage: FileImage(file),
                    backgroundColor: Colors.white,
                  );
                }

                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: widget.radius,
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.white,
                  ),
                  placeholder: (_, __) => ClipOval(
                    child: ShimmerWidget(
                      width: shimmerSize,
                      height: shimmerSize,
                    ),
                  ),
                  errorWidget: (_, __, ___) => CircleAvatar(
                    radius: widget.radius,
                    child: Icon(
                      widget.defaultAvatarIcon,
                      size: errorIconSize,
                      color: AppColors.bodyTextColor,
                    ),
                  ),
                );
              },
            ),

            // Edit Button
            if (widget.showEditButton)
              Positioned(
                bottom: 0,
                right: 0,
                child: Semantics(
                  label: 'Edit profile picture',
                  button: true,
                  child: InkWell(
                    onTap: _handleImageSelection,
                    borderRadius: BorderRadius.circular(widget.radius),
                    child: Container(
                      padding: EdgeInsets.all(widget.radius * 0.17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.editButtonBgColor,
                      ),
                      child: BlocSelector<UserCubit, UserState, bool>(
                        selector: (state) => state.isUpdatingImage,
                        builder: (context, isUpdatingImage) {
                          return isUpdatingImage || _isOpenToUpload
                              ? SizedBox(
                                  width: widget.editButtonSize,
                                  height: widget.editButtonSize,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.blue,
                                  ),
                                )
                              : Icon(
                                  Iconsax.edit_2,
                                  size: widget.editButtonSize,
                                  color: widget.editButtonColor,
                                );
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
