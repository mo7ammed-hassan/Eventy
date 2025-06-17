class UserEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String? phone;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.phone,
  });

  UserEntity.empty()
    : id = '',
      name = '',
      email = '',
      imageUrl = '',
      phone = '';
}
