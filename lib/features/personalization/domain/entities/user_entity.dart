import 'package:eventy/core/constants/app_images.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? location;
  final String? address;
  final String imageUrl;
  final String? phone;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.location,
    this.address,
    this.phone,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
    String? location,
    String? address,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  bool isEqual(UserEntity other) {
    return name == other.name &&
        phone == other.phone &&
        address == other.address &&
        location == other.location &&
        imageUrl == other.imageUrl;
  }

  UserEntity.empty()
    : id = '',
      name = 'Unknown',
      email = 'Not available',
      imageUrl = AppImages.defaultUserImageUrl,
      phone = '',
      location = '',
      address = '';
}
