import 'package:eventy/core/constants/app_images.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? image;

  UserModel({this.id, this.name, this.email, this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'image': image ?? AppImages.defaultUserImageUrl,
  };
}
