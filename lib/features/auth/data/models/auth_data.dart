import 'package:eventy/features/personalization/data/models/user_model.dart';

class AuthData {
  final String accessToken;
  final UserModel user;

  AuthData({required this.accessToken, required this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    accessToken: json['accessToken'],
    user: UserModel.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'user': user.toJson(),
  };
}
