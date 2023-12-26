class RegisterParams {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final String? fcmToken;

  RegisterParams(
      {required this.email,
      required this.password,
      this.name,
      this.phone,
      required this.passwordConfirmation,
      this.fcmToken});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'password_confirmation': passwordConfirmation ?? '',
      'fcm_token': fcmToken ?? '',
    };

    // remove null values from map
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
