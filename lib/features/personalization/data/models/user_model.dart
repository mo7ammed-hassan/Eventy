import 'package:eventy/core/constants/app_images.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final String? image;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.location,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      address: json['address'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'location': location,
    'address': address,
    'image': image ?? AppImages.defaultUserImageUrl,
  };
}
