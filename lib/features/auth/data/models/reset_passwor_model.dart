class ResetPassworModel {
  final String email;
  final String password;
  final String passwordConfirm;

  ResetPassworModel(this.email, this.password, this.passwordConfirm);

  // toJson
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm
      };
}
