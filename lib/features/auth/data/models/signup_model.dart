class SignupModel {
  final String name;
  final String email;
  final String password;
  final String? role;
  final String? confirmPassword;

  SignupModel(this.name, this.email, this.password,
      {this.confirmPassword, this.role = 'admin'});

  // toJson
  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'password': password, 'role': role};
}
