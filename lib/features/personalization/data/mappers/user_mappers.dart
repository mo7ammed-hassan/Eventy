import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/features/personalization/data/models/user_model.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? 'unknown',
      name: name ?? 'Guest',
      email: email ?? 'unknown@email',
      imageUrl: image ?? AppImages.defaultUserImageUrl,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(id: id, name: name, email: email, image: imageUrl);
  }
}
